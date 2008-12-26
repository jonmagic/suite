import traceback
tb = file('tb.txt', 'w')

try:
  import os, string, time, datetime, sys, md5, sha, urllib2, urllib, base64, exceptions, demjson, win32api
  from urllib2 import URLError, HTTPError
  
  def load_config():
    """loads our simple yaml file so that we can access the key value pairs"""
    try:
      config_file = open("config.yaml", "r")
      config_string = config_file.read()
      config = demjson.decode(config_string)
      config_file.close()
    except:
      config = {}
    finally:
      return config
      
  def http_get(url, username, password):
    """this function does all the heavy http gettign"""
    # this proxy bit fixes a bug where python pulls IE proxy info, very not cool
    proxy_support = urllib2.ProxyHandler({})
    opener = urllib2.build_opener(proxy_support)
    urllib2.install_opener(opener)
    # this adds in my password authentication
    password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
    password_mgr.add_password(None, url, username, password)
    handler = urllib2.HTTPBasicAuthHandler(password_mgr)
    opener = urllib2.build_opener(handler)
    urllib2.install_opener(opener)
    # time to build the request
    req = urllib2.Request(url, headers={"Accept":"application/json"})
    # finally lets execute our request and get our response
    try:
      response = urllib2.urlopen(req)
    except:
      response = ""
    finally:
      return response.read()
    
  def http_post(url, username, password, data):
    """this function does all the http posting"""
    # this proxy bit fixes a bug where python pulls IE proxy info, very not cool
    proxy_support = urllib2.ProxyHandler({})
    opener = urllib2.build_opener(proxy_support)
    urllib2.install_opener(opener)
    # this adds in my password authentication
    password_mgr = urllib2.HTTPPasswordMgrWithDefaultRealm()
    password_mgr.add_password(None, url, username, password)
    handler = urllib2.HTTPBasicAuthHandler(password_mgr)
    opener = urllib2.build_opener(handler)
    urllib2.install_opener(opener)
    req = urllib2.Request(url, data, headers={"Accept":"application/json"})
    try:
      response = urllib2.urlopen(req)
    except:
      response = ""
    finally:
      return response
    
      
  def load_sentries(url, device, username, password):
    """retrieves sentries config from site + device + sentries url"""
    try:
      sentries_url = "%s/devices/%s/sentries" % (url, device)
      sentries_string = http_get(sentries_url, username, password)
      sentries_file = open("sentries.yaml", "w")
      print >> sentries_file, sentries_string
      sentries_file.close()
    except:
      sentries_file = open("sentries.yaml", "r")
      sentries_string = sentries_file.read()
      sentries_file.close()
    finally:
      sentries = demjson.decode(sentries_string)
      return sentries
      
  def load_modules(url, sentries):
    """download all the latest modules"""
    for sentry in sentries["sentries"]:
      try:
        module = "%s.py" % (sentry["module"])
        response = urllib2.urlopen(url+"/sma/modules/"+module)
        module_file = file("modules/"+module, "w")
        print >> module_file, response.read()
        module_file.close()
      except:
        print "failed to download module"
        
  def sentries_alert(url, sentries, username, password):
    """put each sentry on alert according to their schedules"""
    try:
      last_run = {}
      first_run = 1
      i = 1
      while i > 0:
        for sentry in sentries["sentries"]:
          if first_run == 1 or last_run[sentry["id"]] < datetime.datetime.now() - datetime.timedelta(0, 0, 0, 0, sentry["survey_interval"], 0, 0):
            result = run_module(sentry["module"], sentry["parameters"])
            last_run[sentry["id"]] = datetime.datetime.now()
            data = "type=Sentry&data=%s" % (result)
            event_url = "%s/sentries/%s/events" % (url, sentry["id"])
            print http_post(event_url, username, password, data)
            print "sentry #%s was last run at %s" % (sentry["id"], last_run[sentry["id"]])
        first_run = 0
        win32api.Sleep(60)
    except:
      win32api.Sleep(60)
      
  def run_module(sma_module, parameters):
    """Run a module, passing it a parameters, then take the return the result"""
    my_module = __import__(sma_module)
    return my_module.run(parameters)

  path = os.getcwd()
  sys.path.append(path+"/modules")  
  config = load_config()
  url = config["site"]["url"]
  device = config["device"]["id"]
  username = config["auth"]["username"]
  password = config["auth"]["password"]
  sentries = load_sentries(url, device, username, password)
  load_modules(url, sentries)
  loop = 1
  while loop >= 1:
    sentries_alert(url, sentries, username, password)
    if loop >= 1 and loop < 60:
      loop = loop + 1
    elif loop == 15:
      sentries = load_sentries(url, device, username, password)
      load_modules(url, sentries)
      loop = 1
  
except:
  print >> tb, "Died"
  traceback.print_exc(file=tb)
  tb.close()