@echo off
echo Membuat folder AllMenu...
powershell -Command "New-Item -ItemType Directory -Path 'AllMenu' -Force"
echo Downloading allmenu.bat ke dalam folder...
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/namorima/menu.bat/main/allmenu.bat' -OutFile 'AllMenu\allmenu.bat' -Force"
echo Selesai! Fail di folder AllMenu. Jalankan AllMenu\allmenu.bat untuk lihat menu.
pause
