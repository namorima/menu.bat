@echo off
title Shortcut Power Menu by Akmal v2.0
color 0a

:: Check Admin Rights
net session >nul 2>&1
if %errorLevel% == 0 (
    set "adminStatus=[Admin Mode: ON]"
) else (
    set "adminStatus=[Admin Mode: OFF]"
)

:menu
cls
echo ===============================================================================
echo                      SHORTCUT POWER MENU BY AKMAL    
echo ===============================================================================
echo %adminStatus%
echo ===============================================================================
echo.
echo [SYSTEM ^& TOOLS]
echo  1. Command Prompt              2. System Info
echo  3. Services Manager            4. Task Manager
echo  5. Device Manager              6. Registry Editor
echo  7. PowerShell Execution Policy
echo.
echo [APLIKASI ^& WORKSPACE]
echo  8. Google Chrome               9. Buka Kerja Space
echo 10. Buka Folder Downloads      11. Buka Folder Startup
echo.
echo [NETWORK ^& SECURITY]
echo 12. Papar IP Printer           13. Windows Defender
echo 14. Event Viewer (Security)    15. Network Connections
echo 16. SeeMyPass (WiFi)           17. IP Config Info
echo 18. Monitor Router Internet    19. Fix Internet Connection
echo.
echo [SYSTEM INFO ^& SETTINGS]
echo 20. Control Panel              21. Disk Management
echo 22. Check Lesen Windows        23. Printer Settings
echo.
echo [WEB ^& UTILITIES]
echo 24. Dashboard Surat            25. Clear Temp Files
echo 26. Change DNS Settings
echo.
echo 27. Keluar
echo ===============================================================================
set /p pilihan=Sila pilih (1-26): 

:: Validate Input
if "%pilihan%"=="" (
    echo.
    echo [ERROR] Sila masukkan pilihan!
    timeout /t 2 >nul
    goto menu
)

:: Check if input is number
set "valid=0"
for %%i in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27) do (
    if "%pilihan%"=="%%i" set "valid=1"
)

if "%valid%"=="0" (
    echo.
    echo [ERROR] Pilihan tidak sah! Sila pilih nombor 1-27.
    timeout /t 2 >nul
    goto menu
)

:: Log the selection
echo %date% %time% - Pilihan %pilihan% dipilih >> "%~dp0menu_log.txt"

:: Execute selection
if "%pilihan%"=="1" goto opt1
if "%pilihan%"=="2" goto opt2
if "%pilihan%"=="3" goto opt3
if "%pilihan%"=="4" goto opt4
if "%pilihan%"=="5" goto opt5
if "%pilihan%"=="6" goto opt6
if "%pilihan%"=="7" goto opt7
if "%pilihan%"=="8" goto opt8
if "%pilihan%"=="9" goto opt9
if "%pilihan%"=="10" goto opt10
if "%pilihan%"=="11" goto opt11
if "%pilihan%"=="12" goto opt12
if "%pilihan%"=="13" goto opt13
if "%pilihan%"=="14" goto opt14
if "%pilihan%"=="15" goto opt15
if "%pilihan%"=="16" goto opt16
if "%pilihan%"=="17" goto opt17
if "%pilihan%"=="18" goto opt18
if "%pilihan%"=="19" goto opt19
if "%pilihan%"=="20" goto opt20
if "%pilihan%"=="21" goto opt21
if "%pilihan%"=="22" goto opt22
if "%pilihan%"=="23" goto opt23
if "%pilihan%"=="24" goto opt24
if "%pilihan%"=="25" goto opt25
if "%pilihan%"=="26" goto opt26
if "%pilihan%"=="27" goto opt27

:opt1
echo.
echo Membuka Command Prompt...
start cmd
timeout /t 1 >nul
goto menu

:opt2
echo.
echo Membuka System Info...
start msinfo32
echo.
echo System Info dibuka!
timeout /t 2 >nul
goto menu

:opt3
echo.
echo Membuka Services Manager...
start services.msc
timeout /t 1 >nul
goto menu

:opt4
echo.
echo Membuka Task Manager...
start taskmgr
timeout /t 1 >nul
goto menu

:opt5
echo.
echo Membuka Device Manager...
start devmgmt.msc
timeout /t 1 >nul
goto menu

:opt6
echo.
echo Membuka Registry Editor...
echo [WARNING] Berhati-hati ketika mengubah registry!
timeout /t 2 >nul
start regedit
goto menu

:opt7
cls
setlocal enabledelayedexpansion
echo ===============================================================================
echo                    POWERSHELL EXECUTION POLICY
echo ===============================================================================
echo.

:: Check if running as admin
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [WARNING] Untuk menukar policy, sila run script sebagai Administrator!
    echo           Anda hanya boleh VIEW policy sahaja.
    echo.
)

echo Mendapatkan Execution Policy semasa...
echo.

:: Get current execution policies
echo ===============================================================================
echo EXECUTION POLICY SEMASA:
echo ===============================================================================

:: Create temp file to store PowerShell output
set "tempFile=%temp%\ps_policy_%random%.txt"

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ExecutionPolicy -List | Format-Table -AutoSize" > "%tempFile%"

type "%tempFile%"
del "%tempFile%" >nul 2>&1

echo ===============================================================================
echo.
echo MAKLUMAT EXECUTION POLICY:
echo -------------------------------------------------------------------------------
echo Restricted      - Tidak boleh run script langsung (paling ketat)
echo AllSigned       - Hanya script yang digitally signed boleh run
echo RemoteSigned    - Local script boleh run, remote perlu signed (recommended)
echo Unrestricted    - Semua script boleh run dengan warning
echo Bypass          - Tiada restrictions, tiada warnings (paling longgar)
echo Undefined       - Tiada policy ditetapkan (inherit dari scope lain)
echo -------------------------------------------------------------------------------
echo.

:policy_menu
echo PILIHAN:
echo -------------------------------------------------------------------------------
echo 1. Set Policy untuk CurrentUser (User sahaja)
echo 2. Set Policy untuk LocalMachine (Semua users - perlu Admin)
echo 3. Set Policy untuk Process (Temporary - session ini sahaja)
echo 4. Reset ke Default (Restricted)
echo 5. View Detailed Info
echo 0. Kembali ke Menu Utama
echo -------------------------------------------------------------------------------
set /p policyChoice=Pilih (0-5): 

if "!policyChoice!"=="0" (
    endlocal
    goto menu
)

if "!policyChoice!"=="1" goto set_currentuser
if "!policyChoice!"=="2" goto set_localmachine
if "!policyChoice!"=="3" goto set_process
if "!policyChoice!"=="4" goto reset_policy
if "!policyChoice!"=="5" goto view_details

echo [ERROR] Pilihan tidak sah!
timeout /t 2 >nul
cls
echo ===============================================================================
echo                    POWERSHELL EXECUTION POLICY
echo ===============================================================================
echo.
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ExecutionPolicy -List | Format-Table -AutoSize"
echo.
goto policy_menu

:set_currentuser
cls
echo ===============================================================================
echo              SET EXECUTION POLICY - CURRENTUSER
echo ===============================================================================
echo.
echo [INFO] Scope: CurrentUser
echo        Hanya affect user: %USERNAME%
echo        Tidak perlu Admin rights
echo.
echo -------------------------------------------------------------------------------
echo Pilih Policy Level:
echo -------------------------------------------------------------------------------
echo 1. Restricted      - Block semua scripts
echo 2. AllSigned       - Hanya signed scripts
echo 3. RemoteSigned    - Local scripts OK, remote perlu signed [RECOMMENDED]
echo 4. Unrestricted    - Semua scripts dengan warning
echo 5. Bypass          - Semua scripts tanpa warning
echo 0. Kembali
echo -------------------------------------------------------------------------------
set /p levelChoice=Pilih level (0-5): 

if "!levelChoice!"=="0" goto opt7

set "policyLevel="
if "!levelChoice!"=="1" set "policyLevel=Restricted"
if "!levelChoice!"=="2" set "policyLevel=AllSigned"
if "!levelChoice!"=="3" set "policyLevel=RemoteSigned"
if "!levelChoice!"=="4" set "policyLevel=Unrestricted"
if "!levelChoice!"=="5" set "policyLevel=Bypass"

if not defined policyLevel (
    echo [ERROR] Pilihan tidak sah!
    timeout /t 2 >nul
    goto set_currentuser
)

echo.
echo ===============================================================================
echo Menetapkan Execution Policy...
echo ===============================================================================
echo.
echo Scope       : CurrentUser
echo Policy      : !policyLevel!
echo.
set /p confirm=Teruskan? (Y/N): 

if /i not "!confirm!"=="Y" goto opt7

echo.
echo Menukar policy...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -ExecutionPolicy !policyLevel! -Scope CurrentUser -Force"

if !errorlevel! EQU 0 (
    echo.
    echo [SUCCESS] Execution Policy telah dikemaskini!
    echo.
    echo Policy baru:
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ExecutionPolicy -Scope CurrentUser"
) else (
    echo.
    echo [ERROR] Gagal menukar Execution Policy!
)

echo.
pause
goto opt7

:set_localmachine
cls
echo ===============================================================================
echo             SET EXECUTION POLICY - LOCALMACHINE
echo ===============================================================================
echo.

:: Check admin rights
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [ERROR] LocalMachine scope memerlukan Administrator rights!
    echo         Sila run script sebagai Administrator.
    echo.
    pause
    goto opt7
)

echo [INFO] Scope: LocalMachine
echo        Affect semua users dalam komputer ini
echo        Memerlukan Admin rights
echo.
echo -------------------------------------------------------------------------------
echo Pilih Policy Level:
echo -------------------------------------------------------------------------------
echo 1. Restricted      - Block semua scripts
echo 2. AllSigned       - Hanya signed scripts
echo 3. RemoteSigned    - Local scripts OK, remote perlu signed [RECOMMENDED]
echo 4. Unrestricted    - Semua scripts dengan warning
echo 5. Bypass          - Semua scripts tanpa warning
echo 0. Kembali
echo -------------------------------------------------------------------------------
set /p levelChoice=Pilih level (0-5): 

if "!levelChoice!"=="0" goto opt7

set "policyLevel="
if "!levelChoice!"=="1" set "policyLevel=Restricted"
if "!levelChoice!"=="2" set "policyLevel=AllSigned"
if "!levelChoice!"=="3" set "policyLevel=RemoteSigned"
if "!levelChoice!"=="4" set "policyLevel=Unrestricted"
if "!levelChoice!"=="5" set "policyLevel=Bypass"

if not defined policyLevel (
    echo [ERROR] Pilihan tidak sah!
    timeout /t 2 >nul
    goto set_localmachine
)

echo.
echo ===============================================================================
echo Menetapkan Execution Policy...
echo ===============================================================================
echo.
echo Scope       : LocalMachine
echo Policy      : !policyLevel!
echo.
echo [WARNING] Ini akan affect SEMUA users dalam komputer ini!
echo.
set /p confirm=Adakah anda pasti? (Y/N): 

if /i not "!confirm!"=="Y" goto opt7

echo.
echo Menukar policy...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -ExecutionPolicy !policyLevel! -Scope LocalMachine -Force"

if !errorlevel! EQU 0 (
    echo.
    echo [SUCCESS] Execution Policy telah dikemaskini!
    echo.
    echo Policy baru:
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ExecutionPolicy -Scope LocalMachine"
) else (
    echo.
    echo [ERROR] Gagal menukar Execution Policy!
)

echo.
pause
goto opt7

:set_process
cls
echo ===============================================================================
echo               SET EXECUTION POLICY - PROCESS
echo ===============================================================================
echo.
echo [INFO] Scope: Process
echo        Hanya affect PowerShell session semasa
echo        Policy akan hilang bila tutup PowerShell
echo        Sesuai untuk testing temporary
echo.
echo -------------------------------------------------------------------------------
echo Pilih Policy Level:
echo -------------------------------------------------------------------------------
echo 1. Restricted      - Block semua scripts
echo 2. AllSigned       - Hanya signed scripts
echo 3. RemoteSigned    - Local scripts OK, remote perlu signed
echo 4. Unrestricted    - Semua scripts dengan warning
echo 5. Bypass          - Semua scripts tanpa warning
echo 0. Kembali
echo -------------------------------------------------------------------------------
set /p levelChoice=Pilih level (0-5): 

if "!levelChoice!"=="0" goto opt7

set "policyLevel="
if "!levelChoice!"=="1" set "policyLevel=Restricted"
if "!levelChoice!"=="2" set "policyLevel=AllSigned"
if "!levelChoice!"=="3" set "policyLevel=RemoteSigned"
if "!levelChoice!"=="4" set "policyLevel=Unrestricted"
if "!levelChoice!"=="5" set "policyLevel=Bypass"

if not defined policyLevel (
    echo [ERROR] Pilihan tidak sah!
    timeout /t 2 >nul
    goto set_process
)

echo.
echo ===============================================================================
echo Membuka PowerShell dengan Policy: !policyLevel!
echo ===============================================================================
echo.
echo PowerShell window akan dibuka dengan temporary policy.
echo Policy hanya active dalam window tersebut.
echo.
pause

start powershell -NoExit -Command "Set-ExecutionPolicy -ExecutionPolicy !policyLevel! -Scope Process -Force; Write-Host ''; Write-Host 'PowerShell Execution Policy (Process): !policyLevel!' -ForegroundColor Green; Write-Host 'Policy ini temporary dan akan hilang bila tutup window ini.' -ForegroundColor Yellow; Write-Host ''; Get-ExecutionPolicy -List"

echo.
echo PowerShell window telah dibuka dengan policy: !policyLevel!
echo.
pause
goto opt7

:reset_policy
cls
echo ===============================================================================
echo                    RESET EXECUTION POLICY
echo ===============================================================================
echo.
echo [WARNING] Ini akan reset Execution Policy ke default (Undefined/Restricted)
echo.
echo Policy yang akan direset:
echo - CurrentUser  : Undefined
echo - LocalMachine : Undefined (jika ada Admin rights)
echo.
set /p confirm=Adakah anda pasti mahu reset? (Y/N): 

if /i not "!confirm!"=="Y" goto opt7

echo.
echo Mereset Execution Policy...
echo.

:: Reset CurrentUser
echo [1/2] Reset CurrentUser...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope CurrentUser -Force" >nul 2>&1
if !errorlevel! EQU 0 (
    echo       [OK] CurrentUser direset
) else (
    echo       [WARNING] Gagal reset CurrentUser
)

:: Reset LocalMachine (if admin)
echo [2/2] Reset LocalMachine...
net session >nul 2>&1
if %errorLevel% EQU 0 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope LocalMachine -Force" >nul 2>&1
    if !errorlevel! EQU 0 (
        echo       [OK] LocalMachine direset
    ) else (
        echo       [WARNING] Gagal reset LocalMachine
    )
) else (
    echo       [SKIPPED] Perlu Admin rights untuk reset LocalMachine
)

echo.
echo [SUCCESS] Reset selesai!
echo.
echo Policy semasa:
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ExecutionPolicy -List | Format-Table -AutoSize"
echo.
pause
goto opt7

:view_details
cls
echo ===============================================================================
echo                DETAILED EXECUTION POLICY INFORMATION
echo ===============================================================================
echo.

:: Get detailed info
echo Current Effective Policy:
powershell -NoProfile -ExecutionPolicy Bypass -Command "Write-Host (Get-ExecutionPolicy) -ForegroundColor Cyan"
echo.

echo All Scopes:
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ExecutionPolicy -List | Format-Table -AutoSize"
echo.

echo -------------------------------------------------------------------------------
echo PENJELASAN SCOPE:
echo -------------------------------------------------------------------------------
echo MachinePolicy   - Set by Group Policy (highest priority, cannot override)
echo UserPolicy      - Set by Group Policy for user
echo Process         - Current PowerShell session sahaja (temporary)
echo CurrentUser     - User yang login sekarang
echo LocalMachine    - Semua users dalam komputer (perlu admin)
echo -------------------------------------------------------------------------------
echo.

echo CADANGAN BEST PRACTICE:
echo -------------------------------------------------------------------------------
echo 1. Untuk development/testing:
echo    CurrentUser = RemoteSigned atau Unrestricted
echo.
echo 2. Untuk production/corporate:
echo    LocalMachine = RemoteSigned (recommended)
echo    atau AllSigned (untuk maximum security)
echo.
echo 3. Untuk temporary testing:
echo    Guna Process scope (tidak permanent)
echo -------------------------------------------------------------------------------
echo.

echo Current User     : %USERNAME%
echo Computer Name    : %COMPUTERNAME%
net session >nul 2>&1
if %errorLevel% EQU 0 (
    echo Admin Rights     : YES
) else (
    echo Admin Rights     : NO
)
echo.
pause
goto opt7

:opt8
echo.
echo Membuka Google Chrome...
start chrome
timeout /t 1 >nul
goto menu

:opt9
echo.
echo Membuka Workspace...
echo - Membuka Outlook...
start "" outlook
timeout /t 2 >nul
echo - Membuka Chrome (Profile 1)...
start chrome --profile-directory="Profile 1"
timeout /t 2 >nul
echo - Membuka XYplorer...
if exist "C:\Users\User\Documents\Software\XYplorer\XYplorer.exe" (
    start "" "C:\Users\User\Documents\Software\XYplorer\XYplorer.exe"
) else (
    echo [WARNING] XYplorer tidak dijumpai!
)
echo.
echo Workspace dibuka!
timeout /t 3 >nul
goto menu

:opt10
echo.
echo Membuka Folder Downloads...
start %userprofile%\Downloads
timeout /t 1 >nul
goto menu

:opt11
echo.
echo Membuka Folder Startup...
start shell:startup
timeout /t 1 >nul
goto menu

:opt12
echo.
echo Memaparkan IP Printer...
start cmd /k "wmic printer get name,portname & echo. & echo Tekan sebarang kekunci untuk tutup... & pause >nul"
goto menu

:opt13
echo.
echo Membuka Windows Defender...
start windowsdefender:
timeout /t 1 >nul
goto menu

:opt14
echo.
echo Membuka Event Viewer (Security)...
start eventvwr.msc /c:Security
timeout /t 1 >nul
goto menu

:opt15
echo.
echo Membuka Network Connections...
start ncpa.cpl
timeout /t 1 >nul
goto menu

:opt16
cls
echo ===============================================================================
echo                         SENARAI KATA LALUAN WiFi
echo ===============================================================================
echo.
echo Mengambil senarai profil WiFi...
echo.
netsh wlan show profiles
echo.
echo -------------------------------------------------------------------------------
echo Mendapatkan kata laluan...
echo -------------------------------------------------------------------------------
echo.

setlocal enabledelayedexpansion
set "wifiCount=0"
set "exportFile=PassWifi.txt"

:: First pass - count WiFi profiles and display passwords
for /f "skip=9 tokens=1,* delims=:" %%a in ('netsh wlan show profiles') do (
    set "profile=%%b"
    set "profile=!profile:~1!"
    if not "!profile!"=="" (
        set /a wifiCount+=1
        echo [!wifiCount!] Nama WiFi: !profile!
        for /f "tokens=1,* delims=:" %%c in ('netsh wlan show profile name^="!profile!" key^=clear ^| findstr "Key Content"') do (
            if not "%%d"=="" (
                echo    Kata Laluan:%%d
                echo.
            ) else (
                echo    Kata Laluan: [Tiada Password/Open Network]
                echo.
            )
        )
    )
)

echo ===============================================================================
echo.
echo PILIHAN TAMBAHAN:
echo 1. Export semua password WiFi ke !exportFile!
echo 2. Kembali ke Menu Utama
echo.
set /p wifiChoice=Pilih (1-2): 

if "!wifiChoice!"=="1" goto export_wifi
if "!wifiChoice!"=="2" (
    endlocal
    goto menu
)

echo [ERROR] Pilihan tidak sah!
timeout /t 2 >nul
goto menu

:export_wifi
cls
echo ===============================================================================
echo                    EXPORT PASSWORD WiFi KE !exportFile!
echo ===============================================================================
echo.
echo Menjana fail !exportFile!...
echo.

(
echo ===============================================================================
echo                      SENARAI PASSWORD WiFi
echo ===============================================================================
echo Generated: %date% %time%
echo Computer: %COMPUTERNAME%
echo User: %USERNAME%
echo ===============================================================================
echo.
) > "!exportFile!"

set "exportCount=0"
for /f "skip=9 tokens=1,* delims=:" %%a in ('netsh wlan show profiles') do (
    set "profile=%%b"
    set "profile=!profile:~1!"
    if not "!profile!"=="" (
        set /a exportCount+=1
        echo [!exportCount!] Nama WiFi: !profile! >> "!exportFile!"
        set "hasPassword=0"
        for /f "tokens=1,* delims=:" %%c in ('netsh wlan show profile name^="!profile!" key^=clear ^| findstr "Key Content"') do (
            if not "%%d"=="" (
                echo    Kata Laluan:%%d >> "!exportFile!"
                set "hasPassword=1"
            )
        )
        if !hasPassword! EQU 0 (
            echo    Kata Laluan: [Tiada Password/Open Network] >> "!exportFile!"
        )
        echo. >> "!exportFile!"
    )
)

(
echo ===============================================================================
echo JUMLAH WiFi PROFIL: !exportCount!
echo ===============================================================================
) >> "!exportFile!"

echo [SUCCESS] Password WiFi telah diexport ke: !exportFile!
echo.
echo Lokasi fail: %CD%\!exportFile!
echo.
echo Kandungan fail:
echo -------------------------------------------------------------------------------
type "!exportFile!"
echo -------------------------------------------------------------------------------
echo.
set /p openFile=Buka fail !exportFile!? (Y/N): 
if /i "!openFile!"=="Y" start notepad "!exportFile!"
echo.
pause
endlocal
goto menu

:opt17
echo.
echo Memaparkan IP Configuration...
start cmd /k "ipconfig /all & echo. & echo Tekan sebarang kekunci untuk tutup... & pause >nul"
goto menu

:opt18
cls
setlocal enabledelayedexpansion
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
echo Mendapatkan maklumat router...
echo.

:: Get default gateway using multiple methods
set "routerIP="

:: Method 1: Using route print to get default gateway
for /f "tokens=3" %%a in ('route print ^| findstr "\<0.0.0.0\>"') do (
    set "tempGateway=%%a"
    :: Check if it's a valid IPv4 (not 0.0.0.0 or On-link)
    echo !tempGateway! | findstr /R "^[1-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
    if !errorlevel! EQU 0 (
        set "routerIP=!tempGateway!"
        goto :found_router
    )
)

:: Method 2: Parse ipconfig for Default Gateway
if not defined routerIP (
    for /f "tokens=*" %%a in ('ipconfig ^| findstr /C:"Default Gateway"') do (
        set "line=%%a"
        
        :: Extract IP after the colon
        for /f "tokens=2 delims=:" %%b in ("!line!") do (
            set "tempIP=%%b"
            :: Remove all spaces
            set "tempIP=!tempIP: =!"
            
            :: Check if it's IPv4 (has dots, starts with number 1-9)
            echo !tempIP! | findstr /R "^[1-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
            if !errorlevel! EQU 0 (
                set "routerIP=!tempIP!"
                goto :found_router
            )
        )
    )
)

:: Method 3: Parse ipconfig /all for DHCP Server
if not defined routerIP (
    for /f "tokens=*" %%a in ('ipconfig /all ^| findstr /C:"DHCP Server"') do (
        set "line=%%a"
        
        :: Extract IP after the colon
        for /f "tokens=2 delims=:" %%b in ("!line!") do (
            set "tempIP=%%b"
            :: Remove all spaces
            set "tempIP=!tempIP: =!"
            
            :: Check if it's IPv4
            echo !tempIP! | findstr /R "^[1-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
            if !errorlevel! EQU 0 (
                set "routerIP=!tempIP!"
                goto :found_router
            )
        )
    )
)

:found_router
if not defined routerIP (
    echo [ERROR] Router IP tidak dijumpai!
    echo.
    echo Troubleshooting:
    echo 1. Pastikan anda tersambung ke rangkaian (Ethernet atau WiFi)
    echo 2. Cuba lihat sendiri dengan 'ipconfig /all'
    echo.
    echo Tekan sebarang kekunci untuk lihat full ipconfig...
    pause >nul
    cls
    ipconfig /all
    echo.
    echo ===============================================================================
    set /p manualIP=Masukkan Router IP secara manual (atau tekan Enter untuk kembali): 
    if not "!manualIP!"=="" (
        set "routerIP=!manualIP!"
        goto :manual_router_set
    )
    endlocal
    goto menu
)

:manual_router_set

:: Get local IP address - IPv4 only from active adapter
set "localIP="
for /f "tokens=*" %%a in ('ipconfig ^| findstr /C:"IPv4 Address"') do (
    set "line=%%a"
    for /f "tokens=2 delims=:" %%b in ("!line!") do (
        set "tempLocalIP=%%b"
        set "tempLocalIP=!tempLocalIP: =!"
        set "tempLocalIP=!tempLocalIP:(Preferred)=!"
        
        :: Check if it's valid IPv4
        echo !tempLocalIP! | findstr /R "^[1-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
        if !errorlevel! EQU 0 (
            set "localIP=!tempLocalIP!"
            goto :found_local
        )
    )
)

:found_local

:: Get subnet mask
set "subnetMask="
for /f "tokens=*" %%a in ('ipconfig ^| findstr /C:"Subnet Mask"') do (
    set "line=%%a"
    for /f "tokens=2 delims=:" %%b in ("!line!") do (
        set "tempMask=%%b"
        set "tempMask=!tempMask: =!"
        
        :: Check if it's valid subnet mask
        echo !tempMask! | findstr /R "^[0-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
        if !errorlevel! EQU 0 (
            set "subnetMask=!tempMask!"
            goto :found_mask
        )
    )
)

:found_mask

:: Get DNS Server - IPv4 only
set "dnsServer="
for /f "tokens=*" %%a in ('ipconfig /all ^| findstr /C:"DNS Servers"') do (
    set "line=%%a"
    for /f "tokens=2 delims=:" %%b in ("!line!") do (
        set "tempDNS=%%b"
        set "tempDNS=!tempDNS: =!"
        
        :: Check if it's IPv4
        echo !tempDNS! | findstr /R "^[1-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
        if !errorlevel! EQU 0 (
            set "dnsServer=!tempDNS!"
            goto :found_dns
        )
    )
)

:found_dns

:: Get DHCP Server
set "dhcpServer="
for /f "tokens=*" %%a in ('ipconfig /all ^| findstr /C:"DHCP Server"') do (
    set "line=%%a"
    for /f "tokens=2 delims=:" %%b in ("!line!") do (
        set "tempDHCP=%%b"
        set "tempDHCP=!tempDHCP: =!"
        
        :: Check if it's IPv4
        echo !tempDHCP! | findstr /R "^[1-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*$" >nul
        if !errorlevel! EQU 0 (
            set "dhcpServer=!tempDHCP!"
            goto :found_dhcp
        )
    )
)

:found_dhcp

:: Get active adapter name
set "adapterName=Unknown"
for /f "tokens=*" %%a in ('ipconfig ^| findstr /C:"adapter Ethernet" /C:"adapter Wi-Fi"') do (
    set "adapterName=%%a"
    set "adapterName=!adapterName:adapter =!"
    set "adapterName=!adapterName::=!"
    goto :found_adapter
)

:found_adapter

echo ===============================================================================
echo MAKLUMAT RANGKAIAN
echo ===============================================================================
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
if defined subnetMask echo Subnet Mask     : !subnetMask!
if defined dhcpServer (
    if "!routerIP!"=="!dhcpServer!" (
        echo DHCP Server     : !dhcpServer! [Same as Router]
    ) else (
        echo DHCP Server     : !dhcpServer!
    )
)
if defined dnsServer echo DNS Server      : !dnsServer!
echo ===============================================================================
echo.

:monitor_menu
echo -------------------------------------------------------------------------------
echo PILIHAN MONITORING:
echo -------------------------------------------------------------------------------
echo 1. Ping Test (Sekali)
echo 2. Continuous Ping (Tekan Ctrl+C untuk berhenti)
echo 3. Trace Route ke Router
echo 4. Lihat Devices dalam Network (ARP Table)
echo 5. Monitor Bandwidth Usage
echo 6. Check Router Web Interface
echo 7. Speed Test ke Internet
echo 8. Full Network Report
echo 9. Lihat Full ipconfig
echo 0. Kembali ke Menu Utama
echo -------------------------------------------------------------------------------
set /p monitorChoice=Pilih (0-9): 

if "!monitorChoice!"=="0" (
    endlocal
    goto menu
)

if "!monitorChoice!"=="1" goto ping_once
if "!monitorChoice!"=="2" goto ping_continuous
if "!monitorChoice!"=="3" goto trace_route
if "!monitorChoice!"=="4" goto arp_table
if "!monitorChoice!"=="5" goto bandwidth_monitor
if "!monitorChoice!"=="6" goto router_interface
if "!monitorChoice!"=="7" goto speed_test
if "!monitorChoice!"=="8" goto full_report
if "!monitorChoice!"=="9" goto show_ipconfig

echo [ERROR] Pilihan tidak sah!
timeout /t 2 >nul
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:show_ipconfig
cls
echo ===============================================================================
echo                            FULL IPCONFIG
echo ===============================================================================
echo.
ipconfig /all
echo.
echo ===============================================================================
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:ping_once
cls
echo ===============================================================================
echo                            PING TEST - ROUTER
echo ===============================================================================
echo.
echo Testing connection to router: !routerIP!
echo.
echo -------------------------------------------------------------------------------
ping -n 10 !routerIP!
echo -------------------------------------------------------------------------------
echo.

:: Calculate packet loss and latency
for /f "tokens=*" %%a in ('ping -n 10 !routerIP! ^| findstr /C:"Lost"') do (
    echo Status: %%a
)

for /f "tokens=*" %%a in ('ping -n 10 !routerIP! ^| findstr /C:"Average"') do (
    echo %%a
)

echo.
echo Testing connection to Internet (Google DNS: 8.8.8.8)
echo.
echo -------------------------------------------------------------------------------
ping -n 10 8.8.8.8
echo -------------------------------------------------------------------------------
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:ping_continuous
cls
echo ===============================================================================
echo                        CONTINUOUS PING - ROUTER
echo ===============================================================================
echo.
echo Pinging router: !routerIP!
echo Tekan Ctrl+C untuk berhenti...
echo.
echo -------------------------------------------------------------------------------
ping -t !routerIP!
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:trace_route
cls
echo ===============================================================================
echo                        TRACE ROUTE - ROUTER
echo ===============================================================================
echo.
echo Tracing route to router: !routerIP!
echo.
echo -------------------------------------------------------------------------------
tracert -d -h 5 !routerIP!
echo -------------------------------------------------------------------------------
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:arp_table
cls
echo ===============================================================================
echo                    DEVICES DALAM NETWORK (ARP TABLE)
echo ===============================================================================
echo.
echo Senarai devices yang tersambung dalam rangkaian:
echo.
echo -------------------------------------------------------------------------------
arp -a
echo -------------------------------------------------------------------------------
echo.
echo [INFO] Senarai di atas menunjukkan semua devices yang pernah/sedang
echo        berkomunikasi dengan komputer anda dalam rangkaian yang sama.
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:bandwidth_monitor
cls
echo ===============================================================================
echo                        BANDWIDTH USAGE MONITOR
echo ===============================================================================
echo.
echo Menunjukkan statistik rangkaian...
echo.
echo -------------------------------------------------------------------------------
netstat -e
echo -------------------------------------------------------------------------------
echo.
echo [INFO] Statistik di atas menunjukkan:
echo        - Bytes Sent: Jumlah data yang dihantar
echo        - Bytes Received: Jumlah data yang diterima
echo        - Errors: Ralat dalam transmisi
echo.
echo Untuk monitoring real-time, guna Resource Monitor (resmon).
set /p openResmon=Buka Resource Monitor? (Y/N): 
if /i "!openResmon!"=="Y" start resmon
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:router_interface
cls
echo ===============================================================================
echo                        ROUTER WEB INTERFACE
echo ===============================================================================
echo.
echo Membuka web interface router di: http://!routerIP!
echo.
echo [INFO] Biasanya, router login credentials adalah:
echo        Username: admin
echo        Password: admin / password / (kosong)
echo.
echo        Atau semak sticker di belakang router anda.
echo.
set /p openBrowser=Buka browser ke router interface? (Y/N): 
if /i "!openBrowser!"=="Y" start http://!routerIP!
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:speed_test
cls
echo ===============================================================================
echo                            INTERNET SPEED TEST
echo ===============================================================================
echo.
echo Testing connection to common servers...
echo.

:: Test to Google
echo [1/4] Testing Google (8.8.8.8)...
for /f "tokens=*" %%a in ('ping -n 5 8.8.8.8 ^| findstr "Average"') do echo       %%a

:: Test to Cloudflare
echo [2/4] Testing Cloudflare (1.1.1.1)...
for /f "tokens=*" %%a in ('ping -n 5 1.1.1.1 ^| findstr "Average"') do echo       %%a

:: Test to Router
echo [3/4] Testing Router (!routerIP!)...
for /f "tokens=*" %%a in ('ping -n 5 !routerIP! ^| findstr "Average"') do echo       %%a

:: Test DNS resolution speed
echo [4/4] Testing DNS Resolution...
echo       Testing www.google.com...
nslookup www.google.com >nul 2>&1
if !errorlevel! EQU 0 (
    echo       [OK] DNS working properly
) else (
    echo       [ERROR] DNS resolution failed
)

echo.
echo -------------------------------------------------------------------------------
echo [INFO] Untuk speed test yang lebih komprehensif:
echo        - Buka browser dan pergi ke: https://fast.com
echo        - Atau: https://speedtest.net
echo -------------------------------------------------------------------------------
echo.
set /p openSpeedTest=Buka Fast.com di browser? (Y/N): 
if /i "!openSpeedTest!"=="Y" start https://fast.com
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:full_report
cls
echo ===============================================================================
echo                        FULL NETWORK REPORT
echo ===============================================================================
echo.
echo Menjana laporan lengkap rangkaian...
echo.

set "reportFile=%userprofile%\Desktop\Network_Report_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.txt"
set "reportFile=%reportFile: =0%"

echo Generating report to: %reportFile%
echo.

(
echo ===============================================================================
echo                        NETWORK DIAGNOSTIC REPORT
echo ===============================================================================
echo Generated: %date% %time%
echo ===============================================================================
echo.
echo --- BASIC INFORMATION ---
ipconfig /all
echo.
echo --- ROUTER PING TEST ---
ping -n 10 !routerIP!
echo.
echo --- INTERNET CONNECTIVITY TEST ---
ping -n 10 8.8.8.8
echo.
echo --- DNS TEST ---
nslookup google.com
echo.
echo --- ROUTING TABLE ---
route print
echo.
echo --- ARP TABLE ---
arp -a
echo.
echo --- NETWORK STATISTICS ---
netstat -e
echo.
echo --- ACTIVE CONNECTIONS ---
netstat -ano
echo.
echo ===============================================================================
echo                            END OF REPORT
echo ===============================================================================
) > "%reportFile%"

echo [SUCCESS] Laporan telah disimpan ke Desktop!
echo.
echo Lokasi: %reportFile%
echo.
set /p openReport=Buka laporan? (Y/N): 
if /i "!openReport!"=="Y" start notepad "%reportFile%"
echo.
pause
cls
echo ===============================================================================
echo                        MONITOR ROUTER INTERNET
echo ===============================================================================
echo.
if not "!adapterName!"=="Unknown" echo Active Adapter  : !adapterName!
echo Router IP       : !routerIP!
if defined localIP echo Computer IP     : !localIP!
echo.
goto monitor_menu

:opt19
cls
setlocal enabledelayedexpansion
echo ===============================================================================
echo                        FIX INTERNET CONNECTION
echo ===============================================================================
echo.
echo Pilih tahap pembaikan yang anda perlukan:
echo.
echo -------------------------------------------------------------------------------
echo [BASIC - Selamat, tidak ganggu settings]
echo 1. Quick Fix           - Release/Renew IP + Flush DNS sahaja
echo                          (Selamat, tidak ganggu DNS/IP manual)
echo.
echo [MODERATE - Boleh ganggu settings sikit]  
echo 2. Standard Fix        - Quick Fix + Reset Winsock
echo                          (DNS manual kekal, IP manual mungkin hilang)
echo.
echo [ADVANCED - Akan reset semua network settings]
echo 3. Full Reset          - Semua (termasuk TCP/IP reset)
echo                          (DNS manual + IP manual akan HILANG)
echo.
echo 4. Custom Fix          - Pilih sendiri apa yang nak reset
echo.
echo 0. Kembali ke Menu
echo -------------------------------------------------------------------------------
set /p fixChoice=Pilih tahap pembaikan (0-4): 

if "!fixChoice!"=="0" (
    endlocal
    goto menu
)

if "!fixChoice!"=="1" goto quick_fix
if "!fixChoice!"=="2" goto standard_fix
if "!fixChoice!"=="3" goto full_reset
if "!fixChoice!"=="4" goto custom_fix

echo [ERROR] Pilihan tidak sah!
timeout /t 2 >nul
goto opt18

:quick_fix
cls
echo ===============================================================================
echo                          QUICK FIX (BASIC)
echo ===============================================================================
echo.
echo [INFO] Quick Fix TIDAK akan:
echo        - Buang DNS manual settings
echo        - Buang IP static settings (jika ada)
echo        - Require restart
echo.
echo Quick Fix HANYA akan:
echo        - Flush DNS cache
echo        - Renew DHCP IP (jika guna automatic)
echo.
echo ===============================================================================
set /p confirm=Teruskan dengan Quick Fix? (Y/N): 

if /i not "!confirm!"=="Y" goto opt18

echo.
echo Memulakan Quick Fix...
echo.

:: Flush DNS only
echo [1/2] Membersihkan DNS Cache...
ipconfig /flushdns >nul 2>&1
if !errorlevel! EQU 0 (
    echo       [OK] DNS Cache dibersihkan
) else (
    echo       [WARNING] Gagal membersihkan DNS Cache
)

:: Only renew if using DHCP (not static)
echo [2/2] Memperbaharui IP (jika guna DHCP)...
ipconfig /renew >nul 2>&1
if !errorlevel! EQU 0 (
    echo       [OK] IP diperbaharui
) else (
    echo       [INFO] IP tidak diperbaharui (mungkin guna static IP)
)

echo.
echo [SUCCESS] Quick Fix selesai!
echo           DNS manual dan IP static (jika ada) masih kekal.
echo.
pause
endlocal
goto menu

:standard_fix
cls
echo ===============================================================================
echo                        STANDARD FIX (MODERATE)
echo ===============================================================================
echo.
echo [WARNING] Standard Fix akan:
echo           - Flush DNS cache
echo           - Reset Winsock (network socket)
echo           - Release/Renew IP
echo.
echo [INFO] Settings yang KEKAL:
echo        ✓ DNS manual masih kekal
echo.
echo [WARNING] Settings yang MUNGKIN hilang:
echo          ✗ IP static mungkin bertukar ke DHCP
echo.
echo ===============================================================================
set /p confirm=Teruskan dengan Standard Fix? (Y/N): 

if /i not "!confirm!"=="Y" goto opt18

echo.
echo Memulakan Standard Fix...
echo.

echo [1/4] Flush DNS Cache...
ipconfig /flushdns >nul 2>&1
echo       [OK] DNS Cache dibersihkan

echo [2/4] Release IP...
ipconfig /release >nul 2>&1
echo       [OK] IP dilepaskan

echo [3/4] Renew IP...
ipconfig /renew >nul 2>&1
echo       [OK] IP diperbaharui

echo [4/4] Reset Winsock...
netsh winsock reset >nul 2>&1
echo       [OK] Winsock direset

echo.
echo [SUCCESS] Standard Fix selesai!
echo.
echo [RECOMMENDATION] Restart komputer untuk hasil terbaik.
set /p restart=Restart sekarang? (Y/N): 
if /i "!restart!"=="Y" shutdown /r /t 10

echo.
pause
endlocal
goto menu

:full_reset
cls
echo ===============================================================================
echo                        FULL RESET (ADVANCED)
echo ===============================================================================
echo.
echo [WARNING] Full Reset akan RESET SEMUA network settings!
echo.
echo Settings yang akan HILANG:
echo ✗ DNS manual (Google DNS, Cloudflare, NextDNS, etc.)
echo ✗ IP static
echo ✗ Custom routing
echo ✗ Network adapter configurations
echo.
echo Semua akan kembali ke DEFAULT/AUTOMATIC!
echo.
echo ===============================================================================
echo.
echo Taip "RESET" untuk confirm (atau tekan Enter untuk batal):
set /p confirmReset=

if /i not "!confirmReset!"=="RESET" (
    echo [CANCELLED] Full Reset dibatalkan.
    timeout /t 2 >nul
    goto opt18
)

echo.
echo Memulakan Full Reset...
echo.

echo [1/5] Release IP Address...
ipconfig /release >nul 2>&1
echo       [OK] IP dilepaskan

echo [2/5] Flush DNS Cache...
ipconfig /flushdns >nul 2>&1
echo       [OK] DNS Cache dibersihkan

echo [3/5] Reset Winsock Catalog...
netsh winsock reset >nul 2>&1
echo       [OK] Winsock direset

echo [4/5] Reset TCP/IP Stack...
netsh int ip reset >nul 2>&1
echo       [OK] TCP/IP direset

echo [5/5] Renew IP Address...
ipconfig /renew >nul 2>&1
echo       [OK] IP diperbaharui

echo.
echo [SUCCESS] Full Reset selesai!
echo.
echo [IMPORTANT] Komputer MESTI restart untuk changes take effect.
echo.
set /p restart=Restart komputer sekarang? (Y/N): 
if /i "!restart!"=="Y" (
    shutdown /r /t 10
    echo Komputer akan restart dalam 10 saat...
) else (
    echo [WARNING] Sila restart komputer secara manual!
)

echo.
pause
endlocal
goto menu

:custom_fix
cls
echo ===============================================================================
echo                          CUSTOM FIX OPTIONS
echo ===============================================================================
echo.
echo Pilih tindakan yang anda mahu jalankan:
echo.

set "do_flush=N"
set "do_release=N"
set "do_renew=N"
set "do_winsock=N"
set "do_tcpip=N"

set /p do_flush=1. Flush DNS Cache? (Y/N): 
set /p do_release=2. Release IP Address? (Y/N): 
set /p do_renew=3. Renew IP Address? (Y/N): 
set /p do_winsock=4. Reset Winsock? (Y/N): 
set /p do_tcpip=5. Reset TCP/IP Stack? (Y/N): 

echo.
echo Tindakan yang akan dijalankan:
if /i "!do_flush!"=="Y" echo - Flush DNS Cache
if /i "!do_release!"=="Y" echo - Release IP Address
if /i "!do_renew!"=="Y" echo - Renew IP Address
if /i "!do_winsock!"=="Y" echo - Reset Winsock
if /i "!do_tcpip!"=="Y" echo - Reset TCP/IP Stack

echo.
set /p confirm=Teruskan? (Y/N): 
if /i not "!confirm!"=="Y" goto opt18

echo.
echo Memulakan Custom Fix...
echo.

set "stepNum=1"

if /i "!do_flush!"=="Y" (
    echo [!stepNum!/5] Flush DNS Cache...
    ipconfig /flushdns >nul 2>&1
    echo       [OK] DNS Cache dibersihkan
    set /a stepNum+=1
)

if /i "!do_release!"=="Y" (
    echo [!stepNum!/5] Release IP Address...
    ipconfig /release >nul 2>&1
    echo       [OK] IP dilepaskan
    set /a stepNum+=1
)

if /i "!do_renew!"=="Y" (
    echo [!stepNum!/5] Renew IP Address...
    ipconfig /renew >nul 2>&1
    echo       [OK] IP diperbaharui
    set /a stepNum+=1
)

if /i "!do_winsock!"=="Y" (
    echo [!stepNum!/5] Reset Winsock...
    netsh winsock reset >nul 2>&1
    echo       [OK] Winsock direset
    set /a stepNum+=1
)

if /i "!do_tcpip!"=="Y" (
    echo [!stepNum!/5] Reset TCP/IP Stack...
    netsh int ip reset >nul 2>&1
    echo       [OK] TCP/IP direset
    set /a stepNum+=1
)

echo.
echo [SUCCESS] Custom Fix selesai!
echo.
pause
endlocal
goto menu

:opt20
echo.
echo Membuka Control Panel...
start control
timeout /t 1 >nul
goto menu

:opt21
echo.
echo Membuka Disk Management...
start diskmgmt.msc
timeout /t 1 >nul
goto menu

:opt22
echo.
echo Memeriksa Lesen Windows...
start cmd /k "slmgr /xpr & echo. & echo Tekan sebarang kekunci untuk tutup... & pause >nul"
goto menu

:opt23
echo.
echo Membuka Printer Settings...
start control printers
timeout /t 1 >nul
goto menu

:opt24
echo.
echo Membuka Dashboard Surat...
start chrome https://www.google.com/webhp
timeout /t 1 >nul
goto menu

:opt25
cls
setlocal enabledelayedexpansion
echo ===============================================================================
echo                            CLEAR TEMP FILES
echo ===============================================================================
echo.
echo Mengira saiz fail temporary...
echo.

:: Calculate size of user temp folder
echo [1/4] Mengira: %temp%
set "userTempSize=0"
for /f "tokens=3" %%a in ('dir /s /-c "%temp%" 2^>nul ^| find "File(s)"') do set "userTempSize=%%a"

:: Calculate size of Windows temp folder
echo [2/4] Mengira: C:\Windows\Temp
set "winTempSize=0"
for /f "tokens=3" %%a in ('dir /s /-c "C:\Windows\Temp" 2^>nul ^| find "File(s)"') do set "winTempSize=%%a"

:: Calculate size of Prefetch folder
echo [3/4] Mengira: C:\Windows\Prefetch
set "prefetchSize=0"
for /f "tokens=3" %%a in ('dir /s /-c "C:\Windows\Prefetch" 2^>nul ^| find "File(s)"') do set "prefetchSize=%%a"

:: Calculate size of Recent folder
echo [4/4] Mengira: %userprofile%\Recent
set "recentSize=0"
for /f "tokens=3" %%a in ('dir /s /-c "%userprofile%\Recent" 2^>nul ^| find "File(s)"') do set "recentSize=%%a"

echo.
echo -------------------------------------------------------------------------------
echo SAIZ FOLDER TEMPORARY:
echo -------------------------------------------------------------------------------

:: Remove commas from numbers (if any)
set "userTempSize=!userTempSize:,=!"
set "winTempSize=!winTempSize:,=!"
set "prefetchSize=!prefetchSize:,=!"
set "recentSize=!recentSize:,=!"

:: Display user temp size
if !userTempSize! GTR 0 (
    set /a userTempMB=!userTempSize! / 1048576
    if !userTempMB! GTR 1024 (
        set /a userTempGB=!userTempMB! / 1024
        echo User Temp       : !userTempGB! GB
    ) else (
        echo User Temp       : !userTempMB! MB
    )
) else (
    echo User Temp       : 0 MB
)

:: Display Windows temp size
if !winTempSize! GTR 0 (
    set /a winTempMB=!winTempSize! / 1048576
    if !winTempMB! GTR 1024 (
        set /a winTempGB=!winTempMB! / 1024
        echo Windows Temp    : !winTempGB! GB
    ) else (
        echo Windows Temp    : !winTempMB! MB
    )
) else (
    echo Windows Temp    : 0 MB
)

:: Display Prefetch size
if !prefetchSize! GTR 0 (
    set /a prefetchMB=!prefetchSize! / 1048576
    if !prefetchMB! GTR 1024 (
        set /a prefetchGB=!prefetchMB! / 1024
        echo Prefetch        : !prefetchGB! GB
    ) else (
        echo Prefetch        : !prefetchMB! MB
    )
) else (
    echo Prefetch        : 0 MB
)

:: Display Recent size
if !recentSize! GTR 0 (
    set /a recentMB=!recentSize! / 1048576
    if !recentMB! GTR 1024 (
        set /a recentGB=!recentMB! / 1024
        echo Recent Files    : !recentGB! GB
    ) else (
        echo Recent Files    : !recentMB! MB
    )
) else (
    echo Recent Files    : 0 MB
)

echo -------------------------------------------------------------------------------

:: Calculate total
set /a totalBytes=!userTempSize! + !winTempSize! + !prefetchSize! + !recentSize!

if !totalBytes! GTR 0 (
    set /a totalMB=!totalBytes! / 1048576
    if !totalMB! GTR 1024 (
        set /a totalGB=!totalMB! / 1024
        echo JUMLAH KESELURUHAN: !totalGB! GB
    ) else (
        echo JUMLAH KESELURUHAN: !totalMB! MB
    )
) else (
    echo JUMLAH KESELURUHAN: 0 MB
)

echo ===============================================================================
echo.
echo [WARNING] Ini akan memadam semua fail temporary di atas.
set /p confirm=Adakah anda pasti mahu meneruskan? (Y/N): 
if /i not "!confirm!"=="Y" (
    endlocal
    goto menu
)

echo.
echo ===============================================================================
echo Membersihkan fail temporary...
echo ===============================================================================
echo.

:: Clear Windows Temp (User)
echo [1/4] Membersihkan %temp%...
del /q /f /s "%temp%\*" 2>nul
for /d %%p in ("%temp%\*") do rd /s /q "%%p" 2>nul
echo       Selesai!

:: Clear Windows Temp (System)
echo [2/4] Membersihkan C:\Windows\Temp...
del /q /f /s "C:\Windows\Temp\*" 2>nul
for /d %%p in ("C:\Windows\Temp\*") do rd /s /q "%%p" 2>nul
echo       Selesai!

:: Clear Prefetch
echo [3/4] Membersihkan Prefetch...
del /q /f /s "C:\Windows\Prefetch\*" 2>nul
echo       Selesai!

:: Clear Recent
echo [4/4] Membersihkan Recent files...
del /q /f /s "%userprofile%\Recent\*" 2>nul
echo       Selesai!

echo.
echo ===============================================================================
echo Mengira ruang yang telah dibersihkan...
echo ===============================================================================
echo.

:: Calculate size after cleanup
set "userTempSizeAfter=0"
for /f "tokens=3" %%a in ('dir /s /-c "%temp%" 2^>nul ^| find "File(s)"') do set "userTempSizeAfter=%%a"

set "winTempSizeAfter=0"
for /f "tokens=3" %%a in ('dir /s /-c "C:\Windows\Temp" 2^>nul ^| find "File(s)"') do set "winTempSizeAfter=%%a"

set "prefetchSizeAfter=0"
for /f "tokens=3" %%a in ('dir /s /-c "C:\Windows\Prefetch" 2^>nul ^| find "File(s)"') do set "prefetchSizeAfter=%%a"

set "recentSizeAfter=0"
for /f "tokens=3" %%a in ('dir /s /-c "%userprofile%\Recent" 2^>nul ^| find "File(s)"') do set "recentSizeAfter=%%a"

:: Remove commas
set "userTempSizeAfter=!userTempSizeAfter:,=!"
set "winTempSizeAfter=!winTempSizeAfter:,=!"
set "prefetchSizeAfter=!prefetchSizeAfter:,=!"
set "recentSizeAfter=!recentSizeAfter:,=!"

:: Calculate total after
set /a totalBytesAfter=!userTempSizeAfter! + !winTempSizeAfter! + !prefetchSizeAfter! + !recentSizeAfter!

:: Calculate freed space
set /a freedBytes=!totalBytes! - !totalBytesAfter!
set /a freedMB=!freedBytes! / 1048576
set /a afterMB=!totalBytesAfter! / 1048576

echo -------------------------------------------------------------------------------
echo HASIL PEMBERSIHAN:
echo -------------------------------------------------------------------------------

:: Display before size
if !totalMB! GTR 1024 (
    set /a displayBeforeGB=!totalMB! / 1024
    echo Sebelum : !displayBeforeGB! GB
) else (
    echo Sebelum : !totalMB! MB
)

:: Display after size
if !afterMB! GTR 1024 (
    set /a displayAfterGB=!afterMB! / 1024
    echo Selepas : !displayAfterGB! GB
) else (
    echo Selepas : !afterMB! MB
)

echo -------------------------------------------------------------------------------

:: Display freed space
if !freedMB! GTR 1024 (
    set /a displayFreedGB=!freedMB! / 1024
    echo RUANG DIBEBASKAN: !displayFreedGB! GB
) else (
    echo RUANG DIBEBASKAN: !freedMB! MB
)

echo ===============================================================================
echo.
echo Pembersihan selesai!
echo.
endlocal
pause
goto menu

:opt26
cls
setlocal enabledelayedexpansion
echo ===============================================================================
echo                          CHANGE DNS SETTINGS
echo ===============================================================================
echo.
echo [INFO] Senarai Network Adapters:
echo -------------------------------------------------------------------------------

:: Get list of network adapters
set "adapterCount=0"
for /f "tokens=*" %%a in ('netsh interface show interface ^| findstr /R /C:"Connected"') do (
    set /a adapterCount+=1
    for /f "tokens=4*" %%b in ("%%a") do (
        set "adapter!adapterCount!=%%b %%c"
        echo !adapterCount!. %%b %%c
    )
)

if !adapterCount! EQU 0 (
    echo [ERROR] Tiada network adapter yang aktif dijumpai!
    echo.
    pause
    endlocal
    goto menu
)

echo -------------------------------------------------------------------------------
echo.
set /p adapterChoice=Pilih adapter (1-!adapterCount!): 

:: Validate adapter choice
if "!adapterChoice!"=="" (
    echo [ERROR] Sila pilih adapter!
    timeout /t 2 >nul
    endlocal
    goto menu
)

if !adapterChoice! LSS 1 (
    echo [ERROR] Pilihan tidak sah!
    timeout /t 2 >nul
    endlocal
    goto menu
)

if !adapterChoice! GTR !adapterCount! (
    echo [ERROR] Pilihan tidak sah!
    timeout /t 2 >nul
    endlocal
    goto menu
)

:: Get selected adapter name
set "selectedAdapter=!adapter%adapterChoice%!"

:: Get current DNS settings
echo.
echo Mendapatkan DNS settings semasa...
set "currentPrimaryDNS="
set "currentSecondaryDNS="
set "isDHCP=0"

:: Check if using DHCP
for /f "tokens=*" %%a in ('netsh interface ip show dns "!selectedAdapter!" ^| findstr /C:"DHCP"') do (
    set "isDHCP=1"
)

:: Get DNS servers
set "dnsCount=0"
for /f "tokens=*" %%a in ('netsh interface ip show dns "!selectedAdapter!" ^| findstr /R /C:"[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*"') do (
    set /a dnsCount+=1
    for /f "tokens=*" %%b in ("%%a") do (
        set "dnsLine=%%b"
        for /f "tokens=*" %%c in ("!dnsLine:* =!") do (
            if !dnsCount! EQU 1 set "currentPrimaryDNS=%%c"
            if !dnsCount! EQU 2 set "currentSecondaryDNS=%%c"
        )
    )
)

cls
echo ===============================================================================
echo                          CHANGE DNS SETTINGS
echo ===============================================================================
echo.
echo Adapter dipilih: !selectedAdapter!
echo.
echo DNS Semasa:
if !isDHCP! EQU 1 (
    echo   Mode: Automatic ^(DHCP^)
    if defined currentPrimaryDNS (
        echo   Primary DNS  : !currentPrimaryDNS!
        if defined currentSecondaryDNS echo   Secondary DNS: !currentSecondaryDNS!
    ) else (
        echo   ^(Mendapat DNS dari DHCP server^)
    )
) else (
    echo   Mode: Manual ^(Static^)
    if defined currentPrimaryDNS (
        echo   Primary DNS  : !currentPrimaryDNS!
        if defined currentSecondaryDNS echo   Secondary DNS: !currentSecondaryDNS!
    ) else (
        echo   ^(Tiada DNS ditetapkan^)
    )
)
echo.
echo ===============================================================================
echo.
echo Pilih DNS Server:
echo -------------------------------------------------------------------------------

:: Check and mark current DNS
set "mark1="
set "mark2="
set "mark3="
set "mark4="
set "mark5="
set "mark6="
set "mark7="
set "mark8="
set "mark10="

if "!currentPrimaryDNS!"=="8.8.8.8" set "mark1= [DEFAULT]"
if "!currentPrimaryDNS!"=="1.1.1.1" set "mark2= [DEFAULT]"
if "!currentPrimaryDNS!"=="208.67.222.222" set "mark3= [DEFAULT]"
if "!currentPrimaryDNS!"=="9.9.9.9" set "mark4= [DEFAULT]"
if "!currentPrimaryDNS!"=="94.140.14.14" set "mark5= [DEFAULT]"
if "!currentPrimaryDNS!"=="84.200.69.80" set "mark6= [DEFAULT]"
if "!currentPrimaryDNS!"=="77.88.8.8" set "mark7= [DEFAULT]"
if "!currentPrimaryDNS!"=="45.90.28.0" set "mark8= [DEFAULT]"
if !isDHCP! EQU 1 set "mark10= [DEFAULT]"

echo  1. Google DNS       (8.8.8.8 / 8.8.4.4)!mark1!
echo  2. Cloudflare DNS   (1.1.1.1 / 1.0.0.1)!mark2!
echo  3. OpenDNS          (208.67.222.222 / 208.67.220.220)!mark3!
echo  4. Quad9 DNS        (9.9.9.9 / 149.112.112.112)!mark4!
echo  5. AdGuard DNS      (94.140.14.14 / 94.140.15.15)!mark5!
echo  6. DNS.Watch        (84.200.69.80 / 84.200.70.40)!mark6!
echo  7. Yandex DNS       (77.88.8.8 / 77.88.8.1)!mark7!
echo  8. NextDNS          (45.90.28.0 / 45.90.30.0) [ID: 6f2bc9]!mark8!
echo  9. Custom DNS       (Masukkan sendiri)
echo 10. Reset ke DHCP    (Automatic)!mark10!
echo  0. Kembali ke Menu
echo -------------------------------------------------------------------------------
set /p dnsChoice=Pilih DNS (0-10): 

if "!dnsChoice!"=="0" (
    endlocal
    goto menu
)

if "!dnsChoice!"=="1" (
    set "primaryDNS=8.8.8.8"
    set "secondaryDNS=8.8.4.4"
    set "dnsName=Google DNS"
)

if "!dnsChoice!"=="2" (
    set "primaryDNS=1.1.1.1"
    set "secondaryDNS=1.0.0.1"
    set "dnsName=Cloudflare DNS"
)

if "!dnsChoice!"=="3" (
    set "primaryDNS=208.67.222.222"
    set "secondaryDNS=208.67.220.220"
    set "dnsName=OpenDNS"
)

if "!dnsChoice!"=="4" (
    set "primaryDNS=9.9.9.9"
    set "secondaryDNS=149.112.112.112"
    set "dnsName=Quad9 DNS"
)

if "!dnsChoice!"=="5" (
    set "primaryDNS=94.140.14.14"
    set "secondaryDNS=94.140.15.15"
    set "dnsName=AdGuard DNS"
)

if "!dnsChoice!"=="6" (
    set "primaryDNS=84.200.69.80"
    set "secondaryDNS=84.200.70.40"
    set "dnsName=DNS.Watch"
)

if "!dnsChoice!"=="7" (
    set "primaryDNS=77.88.8.8"
    set "secondaryDNS=77.88.8.1"
    set "dnsName=Yandex DNS"
)

if "!dnsChoice!"=="8" (
    set "primaryDNS=45.90.28.0"
    set "secondaryDNS=45.90.30.0"
    set "dnsName=NextDNS (ID: 6f2bc9)"
    set "dnsInfo=DoH: https://dns.nextdns.io/6f2bc9"
)

if "!dnsChoice!"=="9" (
    echo.
    set /p primaryDNS=Masukkan Primary DNS: 
    set /p secondaryDNS=Masukkan Secondary DNS: 
    set "dnsName=Custom DNS"
)

if "!dnsChoice!"=="10" (
    echo.
    echo Menetapkan DNS ke Automatic (DHCP)...
    netsh interface ip set dns name="!selectedAdapter!" source=dhcp
    if !errorlevel! EQU 0 (
        echo.
        echo [SUCCESS] DNS telah ditukar ke Automatic!
    ) else (
        echo.
        echo [ERROR] Gagal menukar DNS ke Automatic!
    )
    echo.
    pause
    endlocal
    goto menu
)

:: Validate DNS choice
if not defined primaryDNS (
    echo [ERROR] Pilihan tidak sah!
    timeout /t 2 >nul
    endlocal
    goto menu
)

echo.
echo ===============================================================================
echo Menukar DNS untuk: !selectedAdapter!
echo DNS Server: !dnsName!
echo Primary DNS: !primaryDNS!
echo Secondary DNS: !secondaryDNS!
if defined dnsInfo echo !dnsInfo!
echo ===============================================================================
echo.
set /p confirmDNS=Adakah anda pasti mahu menukar DNS? (Y/N): 

if /i not "!confirmDNS!"=="Y" (
    endlocal
    goto menu
)

echo.
echo Menukar DNS settings...
echo.

:: Set Primary DNS
echo [1/3] Menetapkan Primary DNS...
netsh interface ip set dns name="!selectedAdapter!" static !primaryDNS! primary
if !errorlevel! EQU 0 (
    echo       [OK] Primary DNS ditetapkan: !primaryDNS!
) else (
    echo       [ERROR] Gagal menetapkan Primary DNS!
)

:: Set Secondary DNS
echo [2/3] Menetapkan Secondary DNS...
netsh interface ip add dns name="!selectedAdapter!" !secondaryDNS! index=2
if !errorlevel! EQU 0 (
    echo       [OK] Secondary DNS ditetapkan: !secondaryDNS!
) else (
    echo       [ERROR] Gagal menetapkan Secondary DNS!
)

:: Flush DNS Cache
echo [3/3] Membersihkan DNS Cache...
ipconfig /flushdns >nul
echo       [OK] DNS Cache dibersihkan!

echo.
echo ===============================================================================
echo DNS settings telah dikemaskini!
echo ===============================================================================
echo.

:: Show NextDNS additional info
if "!dnsChoice!"=="8" (
    echo [INFO] NextDNS Configuration (ID: 6f2bc9):
    echo -------------------------------------------------------------------------------
    echo DNS-over-TLS/QUIC : 6f2bc9.dns.nextdns.io
    echo DNS-over-HTTPS    : https://dns.nextdns.io/6f2bc9
    echo IPv6 Primary      : 2a07:a8c0::6f:2bc9
    echo IPv6 Secondary    : 2a07:a8c1::6f:2bc9
    echo -------------------------------------------------------------------------------
    echo.
    echo [NOTE] Script ini menetapkan IPv4 DNS sahaja.
    echo Untuk menggunakan DoH/DoT atau IPv6, sila configure secara manual
    echo atau gunakan NextDNS app: https://nextdns.io/download
    echo.
)

echo Maklumat DNS semasa:
netsh interface ip show dns "!selectedAdapter!"
echo.
echo ===============================================================================
echo.
pause
endlocal
goto menu

:opt27
cls
echo ===============================================================================
echo.
set /p confirm=Adakah anda pasti mahu keluar? (Y/N): 
if /i "%confirm%"=="Y" (
    echo.
    echo Terima kasih kerana menggunakan Shortcut Power Menu!
    timeout /t 2 >nul
    exit
) else (
    goto menu
)

