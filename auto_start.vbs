
Dim app_root
Dim pidfile_path
Dim command

app_root = "D:/apps/syh2014_ruby/"
pidfile_path = "tmp/pids/puma.production.pid"

command = "bundle exec puma -t 16:16 -e production -p 3000 --pidfile " + pidfile_path + ""
'msgbox(command)

Dim oShell1
Set oShell1 = CreateObject("WScript.Shell")
oShell1.CurrentDirectory = app_root
oShell1.run command, 0
Set oShell1 = Nothing

'打开浏览器访问确认
Dim oShell2 : Set oShell2 = CreateObject("WScript.Shell")
oShell2.run "explorer.exe http://localhost:3000",0

