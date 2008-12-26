import win32evtlog, win32evtlogutil, win32security, win32con, winerror, string, time, re, sys

def date2sec(evt_date):
	'''	This function converts dates with format
		'12/23/99 15:54:09' to seconds since 1970. '''
	regexp=re.compile('(.*)\\s(.*)') #store result in site
	reg_result=regexp.search(evt_date)
	date=reg_result.group(1)
	the_time=reg_result.group(2)
	(mon,day,yr)=map(lambda x: string.atoi(x),string.split(date,'/'))
	(hr,min,sec)=map(lambda x: string.atoi(x),string.split(the_time,':'))
	tup=[yr,mon,day,hr,min,sec,0,0,0]
	sec=time.mktime(tup)
	return sec

def run(parameters):
  flags = win32evtlog.EVENTLOG_BACKWARDS_READ|win32evtlog.EVENTLOG_SEQUENTIAL_READ
  evt_dict={win32con.EVENTLOG_AUDIT_FAILURE:'EVENTLOG_AUDIT_FAILURE',win32con.EVENTLOG_AUDIT_SUCCESS:'EVENTLOG_AUDIT_SUCCESS',win32con.EVENTLOG_INFORMATION_TYPE:'EVENTLOG_INFORMATION_TYPE',win32con.EVENTLOG_WARNING_TYPE:'EVENTLOG_WARNING_TYPE',win32con.EVENTLOG_ERROR_TYPE:'EVENTLOG_ERROR_TYPE'}
  computer=''
  begin_sec=time.time()
  time_back = int(parameters.split(",")[1])*3600
  logtype = parameters.split(",")[0]
  hand=win32evtlog.OpenEventLog(computer,logtype)
  count = 0
  try:
    events=1
    while events:
      events=win32evtlog.ReadEventLog(hand,flags,0)
      for ev_obj in events:
      	#check if the event is recent enough
      	#only want data from last 8hrs
      	the_time=ev_obj.TimeGenerated.Format()
      	seconds=date2sec(the_time)
      	if seconds < begin_sec-time_back: break
      	#data is recent enough, so print it out
        evt_type=str(evt_dict[ev_obj.EventType])
        if evt_type == "EVENTLOG_ERROR_TYPE":
          count += 1
        elif evt_type == "EVENTLOG_WARNING_TYPE":
          count += 1
      if seconds < begin_sec-time_back: break #get out of while loop as well
    win32evtlog.CloseEventLog(hand)
    return count
  except:
    print traceback.print_exc(sys.exc_info())
    return "failed"
