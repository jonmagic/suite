import time, re

def parse_log_file(path, filename):
  log_file = open(path+filename, "r")
  content = log_file.readlines()
  log_file.close()
  content.reverse()
  # find most recent line with ********************************
  # read and return the date and time from that line
  for item in content:
    if re.search("\*{32}", item):
      return item[0:20]
      break

def run(command):
  year = time.strftime("%y")
  month = time.strftime("%m")
  filename = "DBUpdate"+year+month+".log"
  try:
    return parse_log_file("C:/Program Files/HeliosBatch/logfile/", filename)
  except:
    return "failed to run test"