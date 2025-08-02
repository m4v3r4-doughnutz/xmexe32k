@echo off
rem Set compiler location:
SET NASM=nasm

rem Set linker location:
SET LNK=\masm32

rem Set linker name: MS_LINK or POLINK
SET LNKNAME=POLINK

SET LNKPATH="%LNK%\bin\link.exe"
if %LNKNAME%==POLINK SET LNKPATH="%LNK%\bin\polink.exe"
if not exist "%NASM%\nasmw.exe" goto Err1
if not exist %LNKPATH% goto Err2
if not exist "%LNK%\lib\kernel32.lib" goto Err3
if %LNKNAME%==MS_LINK SET LNKPATH=%LNKPATH% -ignore:4078
"%NASM%\nasmw" -fwin32 music32k.asm
%LNKPATH% /SUBSYSTEM:WINDOWS /ENTRY:start /RELEASE /OPT:nowin98 /LIBPATH:"%LNK%\lib" /STUB:stub.bin /MERGE:.rdata=.text music32k.obj ufmod.obj kernel32.lib user32.lib winmm.lib
del music32k.obj
goto TheEnd
:Err1
echo Couldn't find nasmw.exe in %NASM%
goto TheEnd
:Err2
if %LNKNAME%==POLINK goto Err4
echo Couldn't find link.exe in %LNK%\bin
goto TheEnd
:Err3
echo Couldn't find library files in %LNK%\lib
goto TheEnd
:Err4
echo Couldn't find polink.exe in %LNK%\bin
:TheEnd
pause
@echo on
cls
