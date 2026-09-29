echo off
setlocal EnableDelayedExpansion
set filename=magnetar.engine
set version=vBETA
echo MADE BY: TeamSc4r4bb
echo REUSE APPROBATED BUT GIVE CREDIT
echo FOR ANY PROJECT BASED OFF THIS ENGINE GIVE PROPER CREDIT
pause
REM DO NOT FORGET TO MODIFY THE VERSION REG VALUE WHEN CHANGING THE VERSION!!!!!!!!!!!!!!!!!!!!!!!
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f > nul
REG ADD HKCU\Software\!filename! /f
reg add HKCU\Software\!filename!\!version! /f
reg add HKCU\Software\!filename!\custom_materials /f
REG ADD HKCU\Software\!filename!\!version! /v version /t REG_SZ /d "!version!" /f
REG ADD HKCU\Software\!filename!\!version! /v made_by /t REG_SZ /d "Team Sc4r4bb" /f
chcp 65001
title !version!
cls

:titleScreen
cls
echo ╔══════════════╗
echo ║              ║
echo ║ [1- Start]   ║
echo ║              ║
echo ║ [2- Tutorial]║
echo ║              ║
echo ╚══════════════╝
choice /c 12

if %errorlevel% equ 1 goto setup
if %errorlevel% equ 2 goto tutorial


:tutorial
cls
echo Use W, A, S, and D to move your cursor around
pause >nul
echo Use the numbers (1 - 9) to select a material category once on the grid menu (where the grid is visible)
pause >nul
echo Use the numbers (1 - 9) once in a material category screen to select a material
pause >nul
echo Press the number 0, when in a material category, to return to the grid screen
pause >nul
echo Press R to search for a specific material (Advanced)
pause >nul
echo Use C to create a custom material from a base (Advanced)
pause >nul
echo Use I to zoom in the grid and use U to zoom out the grid
timeout /T 2 >nul
echo Tutorial complete!
pause >nul
goto titleScreen


:setup
set gx=
set gy=
set gxb=
set gyb=
set sx=0
set sy=0
set r=0
set g=
set b=
set cursoricon=█
set oldposid=
set oldposmaterial=
set selectedmaterial=
set currentposid=%sx%%sy%
set registryPath=ADD HKCU\Software\!filename!\!version!
set creatorsName=
echo what is the width? (only input numbers)
set /p gx=
set /a gxb=%gx% - 1
set tgx=%gx%
echo what is the height? (only input numbers)
set /p gy=
set /a gyb=%gy% - 1
set tgy=%gy%
:: Material Setup :::::
for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
set m11=%ESC%[38;2;137;81;41m▒%ESC%[0m
set m12=[38;2;60;44;14m▒[0m
set m13=[102m[32m▓[0m
set m14=[32m░[0m
set rainbow=
set m15=[38;2;136;108;80m▓[0m
set m16=[38;2;194;178;128m▒[0m
set m17=[38;2;122;139;176m▓[0m
:: Minerals Materials
set m21=[90m▓[0m
set m22=[100m[38;2;20;126;52m▒[0m
set m23=[100m[38;2;0;195;255m▒[0m
set m24=[100m[38;2;224;17;95m░[0m
set m25=[100m[33m░[0m
set m26=[100m[38;2;255;215;0m▓[0m
set m27=[38;2;68;69;69m▓[0m
set m28=[38;2;58;49;40m░[0m
:: Construction Materials
set m31=[40m[33m░[0m
set m32=[38;2;224;229;229m█[0m
set m33=[38;2;184;115;51m░[0m
set m34=[100m[38;2;183;65;14m░[0m
set m35=░
set m36=[38;2;149;165;166m█[0m
:: Miscellaneous Materials
set m41=[38;2;19;96;132m▓[0m
set m42=[34m▒[0m
set m43=[38;2;229;101;32m▒[0m
set m44=[38;2;221;221;255m░[0m
set m45= 
set m46=[38;2;236;242;255m▓[0m

:: Material Editor :::::::
set material_editor_color_r=0
set material_editor_color_g=0
set material_editor_color_b=0
set material_editor_base_r=0
set material_editor_base_g=0
set material_editor_base_b=0
set material_editor_name=
set material_editor_base_example=░▒▓
set material_editor_base=
set material_editor_load_name=

:: Panels :::::::
set panel1=&&set panel2=&&set panel3=&&set panel4=&&set panel5=&&set panel6=&&set panel7=&&set panel8=&&set panel9=
set "panelN1=Dirt   ,Wood   ,Grass  ,Leaves ,Oak    ,Sand   ,Clay   ,       ,       "
set "panelN2=Stone  ,Emerald,Diamond,Ruby   ,Ore    ,Gold   ,Gravel ,Coal   ,       "
set "panelN3=Planks ,Steel  ,Copper ,Rust   ,Glass  ,Concret,       ,       ,       "
set "panelN4=Ice    ,Water  ,Lava   ,Cloud  ,Air    ,Snow   ,       ,       ,       "

:: Grid Slots:::::
cls
echo Do you want to skip Autosave Loading?
echo type Y for yes
echo type N for no
choice /C YN /n
if %errorlevel% equ 1 goto gridsetupblank
if %errorlevel% equ 2 goto gridsetup

:gridsetup
set /a gxb=%gx%-1
set /a gyb=%gy%-1
title loading...
for /l %%y in (0, 1, %gyb%) do (
  for /l %%x in (0, 1, %gxb%) do (
    reg query "HKCU\Software\!filename!\!version!" /v "b%%xs%%y" /reg:64
    if not errorlevel 1 (
	for /f "tokens=3 delims= " %%a in ('reg query HKCU\Software\!filename!\!version! /v b%%xs%%y') do (set b%%xs%%y=%%a) 
)else (
	REG ADD HKCU\Software\!filename!\!version! /v b%%xs%%y /t REG_SZ /d "░" /f >nul && set b%%xs%%y=!glass!
    )
  )
)
title done
goto rendering

:gridsetupblank
for /l %%y in (0, 1, %gyb%) do (
  for /l %%x in (0, 1, %gxb%) do (
    set b%%xs%%y=░
  )
)
goto rendering


:rendering
set /a gxb=%gx%-1
set /a gyb=%gy%-1
cls
set /a r=%random% %%255
set /a g=%random% %%255
set /a b=%random% %%255
set rainbow=[38;2;%r%;%g%;%b%m█

for /l %%y in (0, 1, %gyb%) do (
  set line%%y=
  for /l %%x in (0, 1, %gxb%) do (
    set line%%y=!line%%y! !b%%xs%%y!
  )
  echo !line%%y!
)

:input
echo Version:%version%
echo Move (WASD) or Material
echo  ╔══════════════╗
echo  ║Block Selector║
echo  ║              ║
echo  ║ 1- Natural   ║    
echo  ║              ║
echo  ║ 2- Minerals  ║   
echo  ║              ║
echo  ║ 3- Const     ║
echo  ║              ║
echo  ║ 4- Misc      ║ 
echo  ║              ║
echo  ║ 5-           ║  
echo  ║              ║
echo  ║ 6-           ║ 
echo  ║              ║
echo  ║ 7-           ║  
echo  ║              ║
echo  ║ 8-           ║  
echo  ╚══════════════╝
set currentposid=%sx%%sy%
choice /C WASDQO123456789RCIU /N
:: Materials:::::
if %errorlevel% equ 1 set /a sy-=1 && goto boundaries
if %errorlevel% equ 2 set /a sx-=1 && goto boundaries
if %errorlevel% equ 3 set /a sy+=1 && goto boundaries
if %errorlevel% equ 4 set /a sx+=1 && goto boundaries
if %ERRORLEVEL% EQU 5 set oldposmaterial=%rainbow%
if %errorlevel% equ 6 set oldposmaterial=%selectedmaterial%
if %errorlevel% equ 6 REG ADD HKCU\Software\!filename!\!version! /v b%sx%s%sy% /t REG_SZ /d !selectedmaterial! /f >nul
if %ERRORLEVEL% EQU 7 set panelNum=1 & set panelSelected=%panelN1% & goto selector
if %ERRORLEVEL% EQU 8 set panelNum=2 & set panelSelected=%panelN2% & goto selector
if %ERRORLEVEL% EQU 9 set panelNum=3 & set panelSelected=%panelN3% & goto selector
if %ERRORLEVEL% EQU 10 set panelNum=4 & set panelSelected=%panelN4% & goto selector
if %ERRORLEVEL% EQU 11 goto rendering
if %ERRORLEVEL% EQU 12 goto rendering
if %ERRORLEVEL% EQU 13 goto rendering
if %ERRORLEVEL% EQU 14 goto rendering
if %errorlevel% equ 15 goto rendering
if %errorlevel% equ 16 (
  echo Quick Search/Custom Material
  set /p sMId=
  set selectedmaterial=!sMId!
)
if %errorlevel% equ 17 goto material_editor
if %errorlevel% equ 18 set /a gx-=1 & set /a gy-=1
if %errorlevel% equ 19 set /a gx+=1 & set gy+=1
goto rendering

:selector
for /f "tokens=1-9 delims=," %%A in ("%panelSelected%") do (set panel1=%%A & set panel2=%%B & set panel3=%%C & set panel4=%%D & set panel5=%%E & set panel6=%%F & set panel7=%%G & set panel8=%%H & set panel9=%%I)
echo  ╔══════════════╗
echo  ║Block Selector║
echo  ║              ║
echo  ║ 1- %panel1%  ║    
echo  ║              ║
echo  ║ 2- %panel2%  ║   
echo  ║              ║
echo  ║ 3- %panel3%  ║
echo  ║              ║
echo  ║ 4- %panel4%  ║ 
echo  ║              ║
echo  ║ 5- %panel5%  ║  
echo  ║              ║
echo  ║ 6- %panel6%  ║ 
echo  ║              ║
echo  ║ 7- %panel7%  ║  
echo  ║              ║
echo  ║ 8- %panel8%  ║
echo  ║              ║
echo  ║ 9- %panel9%  ║
echo  ║              ║
echo  ║ 0- Back      ║  
echo  ╚══════════════╝
choice /C 1234567890 /n
if %errorlevel% equ %errorlevel% set /a id=10*%panelNum%+%errorlevel%+0
set selectedmaterial=!m%id%!
goto rendering

:: Unbounding :::::
:boundaries
set /a nbline=%size%-1
if %sx% GTR %gxb% set sx=%gxb%
if %sx% LSS 0 set sx=0
if %sy% GTR %gyb% set sy=%gyb%
if %sy% LSS 0 set sy=0
goto cursorrender

:cursorrender
set b%oldposid%=%oldposmaterial%
set currentposid=%sx%s%sy%
set oldposid=%currentposid%
set oldposmaterial=!b%currentposid%!
set b%currentposid%=%cursoricon%
goto rendering

:material_editor
cls
echo ╔═══════════╗
echo ║Select one ║
echo ║           ║
echo ║           ║
echo ║[1] Create ║
echo ║[2] Load   ║
echo ║[B] Return ║
echo ╚═══════════╝
choice /C 12B
if %errorlevel% equ 1 goto material_editor_base
if %errorlevel% equ 2 goto material_editor_load
if %errorlevel% equ 3 goto rendering

:material_editor_base
cls
echo Material Bases:
echo !material_editor_base_example!
echo Press "C" to input a custom base (all ASCII characters work).
choice /C 123C
if %errorlevel% equ 1 set material_editor_base=░
if %errorlevel% equ 2 set material_editor_base=▒
if %errorlevel% equ 3 set material_editor_base=▓
if %errorlevel% equ 4 set /p material_editor_base=Enter: 

:material_editor_base_color
cls
echo Preview: [48;2;%material_editor_base_r%;%material_editor_base_g%;%material_editor_base_b%m%material_editor_base%[0m
echo Select the material's base color.
echo R: %material_editor_base_r%
echo G: %material_editor_base_g%
echo B: %material_editor_base_b%
echo Press "B" to return to the previous step.
echo Press "O" the select the color.
choice /C QAWSEDOB
if %errorlevel% equ 1 set /a material_editor_base_r+=1
if %errorlevel% equ 2 set /a material_editor_base_r-=1
if %errorlevel% equ 3 set /a material_editor_base_g+=1
if %errorlevel% equ 4 set /a material_editor_base_g-=1
if %errorlevel% equ 5 set /a material_editor_base_b+=1
if %errorlevel% equ 6 set /a material_editor_base_b-=1
if %errorlevel% equ 7 goto material_editor_color
if %errorlevel% equ 8 goto material_editor_base
goto material_editor_base_color

:material_editor_color
cls
echo Preview: [48;2;%material_editor_base_r%;%material_editor_base_g%;%material_editor_base_b%m[38;2;%material_editor_color_r%;%material_editor_color_g%;%material_editor_color_b%m%material_editor_base%[0m
echo Select the material's layer color.
echo R: %material_editor_color_r%
echo G: %material_editor_color_g%
echo B: %material_editor_color_b%
echo Press "B" to return to the previous step.
echo Press "O" the select the color.
choice /C QAWSEDOB
if %errorlevel% equ 1 set /a material_editor_color_r+=1
if %errorlevel% equ 2 set /a material_editor_color_r-=1
if %errorlevel% equ 3 set /a material_editor_color_g+=1
if %errorlevel% equ 4 set /a material_editor_color_g-=1
if %errorlevel% equ 5 set /a material_editor_color_b+=1
if %errorlevel% equ 6 set /a material_editor_color_b-=1
if %errorlevel% equ 7 set selectedmaterial=[48;2;%material_editor_base_r%;%material_editor_base_g%;%material_editor_base_b%m[38;2;%material_editor_color_r%;%material_editor_color_g%;%material_editor_color_b%m%material_editor_base%[0m
if %errorlevel% equ 7 goto material_editor_name
if %errorlevel% equ 8 goto material_editor_base_color
goto material_editor_color

:material_editor_name
cls
echo Please input a name:
set /p material_editor_name=HKCU\Software\!filename!\:
reg add HKCU\Software\!filename!\custom_materials /v !material_editor_name! /t REG_SZ /d "[48;2;%material_editor_base_r%;%material_editor_base_g%;%material_editor_base_b%m[38;2;%material_editor_color_r%;%material_editor_color_g%;%material_editor_color_b%m%material_editor_base%[0m"
goto rendering

:material_editor_load
cls
for /f "tokens=1,3 delims= " %%a in ('reg query HKCU\Software\!filename!\custom_materials') do echo %%a %%b
echo Input the material's name:
set /p material_editor_load_name=
for /f "tokens=3 delims= " %%a in ('reg query HKCU\Software\!filename!\custom_materials /v !material_editor_load_name!') do set selectedmaterial=%%a
cls
echo Preview: %selectedmaterial%
echo Is it the right one?
echo.
echo [1] yes
echo [2] no
echo.
choice /C 12
if %errorlevel% equ 1 goto rendering
if %errorlevel% equ 2 goto material_editor_load