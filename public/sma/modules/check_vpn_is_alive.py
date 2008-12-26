def run(message):
  try:
    import re, subprocess
    hosts = message.split(",")
    results = []
    for host in hosts:
      startupinfo = subprocess.STARTUPINFO()
      startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW
      p = subprocess.Popen('ping -n 1 ' + host, startupinfo=startupinfo, stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
      p.stderr.close() # fixes problem with pythonw
      p.stdin.close() # fixes problem with pythonw
      if re.search('Average = (.*)ms', p.stdout.read()):
        results.append("success")
      else:
        results.append("failure")
    try:
      i = results.index("success")
      return "VPN is up"
    except ValueError:
      return "VPN may be down"
  except:
    return "failed to run test"