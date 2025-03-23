@echo off
REM 执行同步脚本
start /wait "" "Web-Learning.ffs_batch"

REM 确保 FreeFileSync 相关进程完全结束
:WaitForProcess
timeout /t 5 >nul
tasklist /FI "IMAGENAME eq FreeFileSync_x64.exe" | find /I "FreeFileSync_x64.exe" >nul
set "process1=%errorlevel%"
tasklist /FI "IMAGENAME eq FreeFileSync.exe" | find /I "FreeFileSync.exe" >nul
set "process2=%errorlevel%"

if %process1% EQU 0 goto WaitForProcess
if %process2% EQU 0 goto WaitForProcess

REM 进程结束后，创建 sync_done.txt
echo 同步完成，当前时间：%date% %time% > "F:\Auto_Backup_Script\sync_done.txt"
echo U盘同步完成。
exit /b 0
