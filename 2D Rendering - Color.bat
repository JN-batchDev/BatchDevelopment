@echo off
setlocal EnableDelayedExpansion
chcp 65001
cls

:: Variable Setup
set x=5
set y=5
set symbols=Oo￮◦.
set gridsize=10
set /a nbline=%gridsize%-1
set /a rptCycle=%gridsize%-1
set hs=O
set empty=.

:: Coordinates positionning
:setup
for /l %%l in (0, 1, %nbline%) do (

    set line%%l=%empty%
    set x%%l=[41m%empty%[0m
    set c%%l=%empty%
)

:: Processing coordinates
set hs=[34m!symbols:~%z%,1![0m
for /l %%i in (0, 1, %nbline%) do (

    if %x%==%%i (

        set x%%i=%hs%
        set c%%i=[42m.[0m
    )
)
for /l %%i in (0, 1, %nbline%) do (

    if %y%==%%i (
	set line%%i=!x0!
        for /l %%o in (1, 1, %rptcycle%) do (
	    set line%%i=!line%%i! !x%%o!
        )

    )else (

	set line%%i=!c0!
        for /l %%o in (1, 1, %rptcycle%) do (
	    set line%%i=!line%%i! !c%%o!
        )

    )
)

:: Rendering
:error
cls
for /l %%o in (0, 1, %nbline%) do (

    echo !line%%o!
)
echo x:%x% y:%y%

:: Inputting
choice /C wasd

if %ERRORLEVEL% EQU 1 set /a y-=1
if %ERRORLEVEL% EQU 2 set /a x-=1
if %ERRORLEVEL% EQU 3 set /a y+=1
if %ERRORLEVEL% EQU 4 set /a x+=1

:: Unbounding
if %x% GTR %nbline% set x=%nbline% && goto error
if %x% LSS 0 set x=0 && goto error
if %y% GTR %nbline% set y=%nbline% && goto error
if %y% LSS 0 set y=0 && goto error
goto setup