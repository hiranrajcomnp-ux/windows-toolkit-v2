@echo off
setlocal EnableExtensions
title VASKAR - ULTIMATE WINDOWS TOOLKIT
mode con: cols=118 lines=42 >nul 2>&1
chcp 65001 >nul

:: VASKAR - ULTIMATE WINDOWS TOOLKIT
:: Safe Windows administration and troubleshooting menu.
:: Run as Administrator for elevated maintenance options.

:menu
cls
call :banner
echo.
echo  ===================================== MAIN MODULES ================================================
echo.
echo  +-------------------------------+  +-------------------------------+  +-------------------------------+
echo  ^|       SYSTEM & ADMIN          ^|  ^|       NETWORK & INTERNET      ^|  ^|       REPAIR & MANAGEMENT     ^|
echo  +-------------------------------+  +-------------------------------+  +-------------------------------+
echo  ^| [01] System Information       ^|  ^| [02] Network Information      ^|  ^| [03] Windows Repair (SFC)     ^|
echo  ^| [04] User / Account Details   ^|  ^| [05] Flush DNS Cache          ^|  ^| [06] DISM Image Repair        ^|
echo  ^| [07] Task Manager             ^|  ^| [08] Renew IP Address         ^|  ^| [09] Disk Scan (Online)       ^|
echo  ^| [10] Windows Update Settings  ^|  ^| [11] Ping Google              ^|  ^| [12] Disk Cleanup             ^|
echo  ^| [13] Device Manager           ^|  ^| [14] Trace Route              ^|  ^| [15] Windows Firewall Status  ^|
echo  ^| [16] Services Manager         ^|  ^| [17] Open Network Settings    ^|  ^| [18] Microsoft Defender Scan  ^|
echo  ^| [19] Event Viewer             ^|  ^| [20] Power / Battery Report   ^|  ^| [21] Storage Overview         ^|
echo  ^| [22] System Restore Settings  ^|  ^| [23] Shared Folders           ^|  ^| [24] Create Restore Point     ^|
echo  ^| [25] Startup Apps             ^|  ^| [26] Remote Desktop Settings  ^|  ^| [27] Clean User Temp Files    ^|
echo  ^| [28] Control Panel            ^|  ^| [29] Windows Security         ^|  ^| [30] About VASKAR Toolkit     ^|
echo  +-------------------------------+  +-------------------------------+  +-------------------------------+
echo.
echo  ======================================= QUICK ACTIONS =============================================
echo.
echo       [I] Open CMD as Admin        [P] Open PowerShell        [R] Restart PC        [X] Exit
echo.
echo  ---------------------------------------------------------------------------------------------------
echo                                      BY VASKAR  ^|  WINDOWS TOOLKIT
echo  ---------------------------------------------------------------------------------------------------
echo.
set "choice="
set /p "choice=  Enter module number or shortcut: "

if /i "%choice%"=="X" goto end
if /i "%choice%"=="I" goto admincmd
if /i "%choice%"=="P" goto powershell
if /i "%choice%"=="R" goto restart
if "%choice%"=="1" set "choice=01"
if "%choice%"=="2" set "choice=02"
if "%choice%"=="3" set "choice=03"
if "%choice%"=="4" set "choice=04"
if "%choice%"=="5" set "choice=05"
if "%choice%"=="6" set "choice=06"
if "%choice%"=="7" set "choice=07"
if "%choice%"=="8" set "choice=08"
if "%choice%"=="9" set "choice=09"

if "%choice%"=="01" goto sysinfo
if "%choice%"=="02" goto netinfo
if "%choice%"=="03" goto sfc
if "%choice%"=="04" goto userinfo
if "%choice%"=="05" goto flushdns
if "%choice%"=="06" goto dism
if "%choice%"=="07" start "" taskmgr & goto menu
if "%choice%"=="08" goto renewip
if "%choice%"=="09" goto chkdsk
if "%choice%"=="10" start "" ms-settings:windowsupdate & goto menu
if "%choice%"=="11" goto pingtest
if "%choice%"=="12" start "" cleanmgr & goto menu
if "%choice%"=="13" start "" devmgmt.msc & goto menu
if "%choice%"=="14" goto traceroute
if "%choice%"=="15" goto firewall
if "%choice%"=="16" start "" services.msc & goto menu
if "%choice%"=="17" start "" ms-settings:network & goto menu
if "%choice%"=="18" goto defenderscan
if "%choice%"=="19" start "" eventvwr.msc & goto menu
if "%choice%"=="20" goto battery
if "%choice%"=="21" goto storage
if "%choice%"=="22" start "" rstrui.exe & goto menu
if "%choice%"=="23" start "" fsmgmt.msc & goto menu
if "%choice%"=="24" goto restorepoint
if "%choice%"=="25" start "" ms-settings:startupapps & goto menu
if "%choice%"=="26" start "" ms-settings:remotedesktop & goto menu
if "%choice%"=="27" goto tempclean
if "%choice%"=="28" start "" control.exe & goto menu
if "%choice%"=="29" start "" windowsdefender: & goto menu
if "%choice%"=="30" goto about
echo.
echo  Invalid selection. Please choose a listed option.
timeout /t 2 >nul
goto menu

:banner
color 0B
echo  ==================================================================================================
echo   __      __ ____    _____ _  __    _    ____  
echo   \ \    / // __ \  / ____| |/ /   / \  |  _ \ 
echo    \ \  / /| |  | || |    | ' /   / _ \ | |_) |
echo     \ \/ / | |__| || |____| . \  / ___ \|  _ ^< 
echo      \__/   \____/  \_____|_|\_\/_/   \_\_| \_\
echo.
echo                         V A S K A R   -   U L T I M A T E   W I N D O W S   T O O L K I T
echo                                      ADMIN COMMAND CENTER  ^|  VERSION 1.0
echo  ==================================================================================================
exit /b

:sysinfo
cls
call :banner
echo.
systeminfo
call :wait
goto menu

:netinfo
cls
call :banner
echo.
ipconfig /all
echo.
route print
call :wait
goto menu

:userinfo
cls
call :banner
echo.
echo  Current user: %USERNAME%
echo  Computer: %COMPUTERNAME%
echo.
whoami /all
call :wait
goto menu

:flushdns
cls
call :banner
echo.
ipconfig /flushdns
call :wait
goto menu

:renewip
cls
call :banner
echo.
echo  This will briefly disconnect network connections while renewing DHCP.
call :admincheck
if errorlevel 1 goto menu
ipconfig /release
ipconfig /renew
call :wait
goto menu

:sfc
cls
call :banner
echo.
echo  System File Checker will scan and attempt to repair protected Windows system files.
call :admincheck
if errorlevel 1 goto menu
sfc /scannow
call :wait
goto menu

:dism
cls
call :banner
echo.
echo  DISM RestoreHealth can take a while and may use Windows Update.
call :admincheck
if errorlevel 1 goto menu
DISM /Online /Cleanup-Image /RestoreHealth
call :wait
goto menu

:chkdsk
cls
call :banner
echo.
echo  Runs an online scan of the Windows drive (no scheduled reboot repair).
call :admincheck
if errorlevel 1 goto menu
chkdsk %SystemDrive% /scan
call :wait
goto menu

:pingtest
cls
call :banner
echo.
ping 8.8.8.8 -n 4
echo.
ping google.com -n 4
call :wait
goto menu

:traceroute
cls
call :banner
echo.
set "target="
set /p "target=  Enter hostname or IP (default: google.com): "
if not defined target set "target=google.com"
tracert "%target%"
call :wait
goto menu

:firewall
cls
call :banner
echo.
netsh advfirewall show allprofiles
call :wait
goto menu

:defenderscan
cls
call :banner
echo.
echo  Starting Microsoft Defender quick scan...
powershell -NoProfile -Command "Start-MpScan -ScanType QuickScan"
if errorlevel 1 echo  Defender scan could not be started. Check Windows Security and permissions.
call :wait
goto menu

:battery
cls
call :banner
echo.
echo  Generating battery report in your user profile...
powercfg /batteryreport /output "%USERPROFILE%\Desktop\Vaskar-Battery-Report.html"
if exist "%USERPROFILE%\Desktop\Vaskar-Battery-Report.html" start "" "%USERPROFILE%\Desktop\Vaskar-Battery-Report.html"
call :wait
goto menu

:storage
cls
call :banner
echo.
echo  DISK SUMMARY
echo  --------------------------------------------------------------------------------
wmic logicaldisk get caption,freespace,size,filesystem 2>nul
if errorlevel 1 powershell -NoProfile -Command "Get-Volume | Format-Table DriveLetter,FileSystemLabel,FileSystem,Size,SizeRemaining -Auto"
echo.
echo  Physical disks:
powershell -NoProfile -Command "Get-PhysicalDisk | Format-Table FriendlyName,MediaType,HealthStatus,OperationalStatus -Auto"
call :wait
goto menu

:restorepoint
cls
call :banner
echo.
echo  Create a Windows restore point. System Protection must be enabled.
call :admincheck
if errorlevel 1 goto menu
powershell -NoProfile -Command "Checkpoint-Computer -Description 'Vaskar Toolkit Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
if errorlevel 1 echo  Could not create restore point. Enable System Protection and try again.
call :wait
goto menu

:tempclean
cls
call :banner
echo.
echo  This removes files from your current user's TEMP folder only.
echo  Files currently in use will be skipped. No Downloads or Documents are touched.
set "confirm="
set /p "confirm=  Continue? (Y/N): "
if /i not "%confirm%"=="Y" goto menu
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%D in ("%TEMP%\*") do rd /s /q "%%D" >nul 2>&1
echo.
echo  User temporary-file cleanup finished. Some locked files may remain.
call :wait
goto menu

:admincmd
powershell -NoProfile -Command "Start-Process cmd -Verb RunAs"
goto menu

:powershell
start "" powershell.exe
goto menu

:restart
echo.
echo  WARNING: This will restart Windows in 30 seconds.
set "confirm="
set /p "confirm=  Type RESTART to confirm: "
if /i "%confirm%"=="RESTART" shutdown /r /t 30
goto menu

:about
cls
call :banner
echo.
echo  VASKAR ULTIMATE WINDOWS TOOLKIT
echo  Version: 1.0
echo  Author: Vaskar
echo.
echo  A batch-based Windows administration and troubleshooting launcher.
echo  Some maintenance features require Administrator privileges.
echo  This toolkit does not bypass Windows activation or disable security protections.
call :wait
goto menu

:admincheck
net session >nul 2>&1
if errorlevel 1 (
  echo.
  echo  [!] Administrator privileges are required for this action.
  echo      Right-click this file and choose "Run as administrator".
  echo.
  pause
  exit /b 1
)
exit /b 0

:wait
echo.
pause
exit /b

:end
cls
echo.
echo  Thank you for using VASKAR ULTIMATE WINDOWS TOOLKIT.
echo  BY VASKAR
timeout /t 2 >nul
endlocal
exit
