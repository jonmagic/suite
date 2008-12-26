def service_state(name):
  try:
    import win32service, win32serviceutil
    if win32serviceutil.QueryServiceStatus(name)[1] == 4:
      return "%s is running" % (name)
    else:
      return "%s is stopped" % (name)
  except:
    return "failed"

def run(parameters):
  return service_state(parameters)
