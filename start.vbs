Dim WinScriptHost
Set WinScriptHost = CreateObject("WScript.Shell")
WinScriptHost.Run "bundle exec thin start -p 3000", 0
Set WinScriptHost = Nothing