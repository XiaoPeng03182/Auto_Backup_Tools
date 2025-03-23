@echo off
chcp 65001 >nul 

REM 确保路径存在
set folder="F:\Auto_Backup_Script"
if not exist %folder% (
    echo 路径不存在，无法创建文件！
    pause
    exit /b
)

REM 在同步完成后创建 sync_done.txt 文件并记录当前时间
echo 同步完成，当前时间：%date% %time% > "%folder%\sync_done.txt"

REM 确认文件创建是否成功
if exist "%folder%\sync_done.txt" (
    echo 文件创建成功！
) else (
    echo 文件创建失败！
)

REM 输出完成信息
echo U盘同步完成。
pause
