
'结束当前进程,如果有的话
dim pidfile_path, success
success = false
pidfile_path = "tmp/pids/puma.production.pid"

set fs = createobject("scripting.filesystemobject")
If fs.fileExists(pidfile_path) Then
	set ts=fs.opentextfile(pidfile_path,1,true)
	pid=ts.readline
	'msgbox(pid)

	Dim objWMIService, colProcessList, objProcess
	Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Set colProcessList = objWMIService.ExecQuery("Select * from Win32_Process Where processid=" & pid & "")

	For Each objProcess In colProcessList
		If objProcess.name = "ruby.exe" Then
			Dim oShell : Set oShell = CreateObject("WScript.Shell")
			oShell.Run "tskill " & pid & "", , True
		End If
	Next
	
end If


'重启进程
Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run "bundle exec puma -t 16:16 -e production -p 3000 --pidfile " & pidfile_path & "", 0
Set WinScriptHost = Nothing

'打开浏览器访问确认
Dim oShell2 : Set oShell2 = CreateObject("WScript.Shell")
oShell2.run "explorer.exe http://localhost:3000",0

