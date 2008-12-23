# Loop.
#   Do any survey that either doesn't have a last_surveyed_at, or is past last_surveyed_at + survey_interval. And is not currently ignored.
#     Record last_surveyed_at
#     Notify if haven't notified too recently
#       Record last_notified_at
# 
# Later: Partition groups of surveys into separate threads to get it done faster.
require 'fileutils'

def loggit!(msg)
  File.open("log/watcher.log", 'a') do |log|
    log << "[#{Time.now.strftime("%D %T")}] #{msg}\n"
  end
  msg
end
def store_pid(pid)
  File.open("log/watcher.pid", 'w'){|f| f.write("#{pid}\n")}
end
def delete_pidfile
  FileUtils.rm("log/watcher.pid")
end  

def watch!
  # This will naturally migrate different surveys to need run slightly apart from one another.
  while(sleep(1))
    Sentry.find(:all).each do |sentry|
      begin
        if (sentry.last_surveyed_at.nil? || Time.now > sentry.last_surveyed_at.to_time + sentry.survey_interval)
          begin
            success = sentry.survey!
            if success
              loggit! "SUCCESS #{sentry.device.name} / #{sentry.goggle.name}"
              sentry.last_notified_at = nil
            else !success
              loggit! "FAILURE #{sentry.device.name} / #{sentry.goggle.name}"
              if sentry.last_notified_at.nil? || (sentry.notifications_to_send > 1 && Time.now > sentry.last_notified_at.to_time + sentry.maximum_notify_frequency)
                if sentry.notify!
                  sentry.last_notified_at = Time.now 
                  loggit! "  ->  NOTIFIED"
                else
                  loggit! "  ->  Could Not Notify"
                end
              end
            end
          rescue => e
            STDERR << loggit!("ERROR - (#{sentry.device.name} / #{sentry.goggle.name}): #{e}")
            if sentry.last_notified_at.nil? || (sentry.notifications_to_send > 1 && Time.now > sentry.last_notified_at.to_time + sentry.maximum_notify_frequency)
              loggit! "  ->  NOTIFIED of ERROR"
              sentry.last_notified_at = Time.now if sentry.notify!("Sentry #{sentry.device.name} / #{sentry.goggle.name} errored: #{e}")
            end
          ensure
            sentry.last_surveyed_at = Time.now
            sentry.save
          end
        end
      rescue => e
        STDERR << loggit!("ERROR - Was going to cause exit on Sentry #{sentry.device.name}! Error: #{e}")
        sentry.notify!("Sentry #{sentry.device.name} Exit-causing error: #{e}", 'dcparker@gmail.com')
      end
    end
  end
end

watch!

# 
# def start_daemon!
#   if File.exists?("log/watcher.pid")
#     pid = IO.read("log/watcher.pid").chomp.to_i
#     puts "Already running on process #{pid}!"
#   else
#     fork do
#       Process.setsid
#       exit if fork
#       at_exit {
#         delete_pidfile
#         loggit!('Daemon Stopped')
#       }
#       File.umask 0000
#       STDIN.reopen "/dev/null"
#       trap("TERM") { exit }
#       trap("INT")  { exit }
#       store_pid(Process.pid)
#       puts "Started Watcher Daemon on process #{Process.pid}."
#       STDOUT.reopen "/dev/null", "a"
#       STDERR.reopen "/dev/null"
#       loggit!('Daemon Starting...')
#       STDERR.reopen(File.open("log/watcher_errors.log", 'a'))
#       Merb::Config[:environment] = 'production' unless ARGV[1] == 'development' || Merb::Config[:environment]
#       ::Merb::BootLoader.initialize_merb
#       loggit!('  ->  Started')
#       begin
#         watch!
#       rescue => e
#         STDERR << loggit!("Program error OUTSIDE loop!  > #{e}")
#         email = Merb::Mailer.new(:to => 'dcparker@gmail.com',
#                                  :from => "imonit@sabretechllc.com",
#                                  :subject => "iMonit Daemon Stopped on ERROR",
#                                  :text => "Program error OUTSIDE loop!  > #{e}")
#         email.deliver!
#       end
#     end
#   end
# end
# 
# def stop_daemon!
#   begin
#     pid = IO.read("log/watcher.pid").chomp.to_i
#     Process.kill("INT", pid)
#     loggit! "Daemon Stopped Manually :)"
#     puts "Stopped Watcher Daemon on process #{pid}"
#   rescue => k
#     puts "Failed to kill! #{k}"
#   ensure
#     exit
#   end
# end
# 
# case ARGV[0]
# when 'start'
#   start_daemon!
# when 'stop'
#   stop_daemon!
# when 'log'
#   puts IO.read("log/watcher.log")
# else
#   puts "Usage: ruby lib/daemon.rb start|stop|log"
# end
