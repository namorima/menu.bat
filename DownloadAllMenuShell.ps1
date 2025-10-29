# jalan kan ini "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser" jika error policy (tanpa tanda petik)
# atau ini utk session semasa sahaja "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process"
# Buat folder AllMenu jika belum ada
New-Item -ItemType Directory -Path "AllMenu" -Force

# Download fail ke dalam folder itu (overwrite jika sudah ada)
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/namorima/menu.bat/main/allmenu.bat" -OutFile "AllMenu\allmenu.bat" -Force

Write-Host "Selesai! Fail allmenu.bat sudah didownload ke folder AllMenu."
