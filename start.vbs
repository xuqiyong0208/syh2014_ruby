Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run "bundle exec puma -t 16:16 -e production -p 3000 --pidfile tmp/pids/puma.production.pid", 0
Set WinScriptHost = Nothing