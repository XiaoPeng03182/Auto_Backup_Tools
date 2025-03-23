@echo off
chcp 65001 >nul

REM --- 等待U盘（F:盘）插入 ---
echo 正在等待U盘(F:)插入...
:WaitForU
if not exist F:\ (
    timeout /t 5 >nul
    goto WaitForU
)
echo U盘已插入F:。

REM --- U盘已插入后，检查并删除上次遗留的标志文件 ---
if exist "F:\Auto_Backup_Script\sync_done.txt" (
    del /f "F:\Auto_Backup_Script\sync_done.txt"
    echo 清理上次遗留的标志文件成功。
) else (
    echo 无遗留标志文件。
)

REM --- 通过 VBS 隐藏运行 Autorun.exe ---
cscript //nologo "E:\AAA-Tools\AutorunByUpan\run_hidden.vbs"

echo 正在等待同步任务完成...
set "maxWait=600"
set "elapsed=0"

:WaitLoop
REM 检查U盘中是否生成标志文件（同步任务完成时同步脚本会创建此文件）
if exist "F:\Auto_Backup_Script\sync_done.txt" (
    goto SyncDone
)
timeout /t 5 >nul
set /a elapsed+=5
if %elapsed% GEQ %maxWait% (
    goto WaitTimeout
)
goto WaitLoop

:SyncDone
REM 同步完成后弹出提示对话框
mshta "javascript:alert('U盘同步Web-Learning文件夹成功');close();"
goto KillProcesses

:WaitTimeout
mshta "javascript:alert('等待同步任务超时，请检查任务状态');close();"

:KillProcesses
REM 终止 Autorun.exe 和 Autorun_old.exe 进程
taskkill /f /im Autorun.exe
taskkill /f /im Autorun_old.exe
exit
