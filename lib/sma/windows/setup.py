import traceback, os, sys, uuid, subprocess, webbrowser, demjson
tb = file('setup.txt', 'w')

try:
  def load_config():
    if os.path.exists("config.yaml"):
      config_file = open("config.yaml", "r")
      config_string = config_file.read()
      config = demjson.decode(config_string)
      config_file.close()
      return config
    else:
      return "failed"
      
  config = load_config()
  if config == "failed":
    print "failed"
  else:
    url = "%s/devices/%s" % (config["site"]["url"], config["device"]["id"])
    webbrowser.open_new(url)
    sys.exit()

except:
  print >> tb, "Died"
  traceback.print_exc(file=tb)
  tb.close()