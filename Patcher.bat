@ECHO off

REM Bienvenidos a mi desastre
REM Made In Venezuela
REM By ViktorMax3
TITLE Super Mario Galaxy Riivolution to WBFS
MODE con: cols=56 lines=45
COLOR E0
CD "%~dp0"
SET WITPATH=bin\wit
SET RARPATH=bin\rar
SET SZSPATH=bin\wstrt
SET RIIVDIR=riiv_mods/
SET Spanish=yes
SET English=yes
SET Deutsch=no
SET f=8GB
SET f2=4GB
SET req=800
SET req2=400
SET Box_T=    /==============================================\
SET Box_B=    \==============================================/
SETlocal enableDelayedExpansion
SET NL=^



:Magic
IF "%~1"=="" (
GOTO :Select_leng
) ELSE (
GOTO :drag_drop
)

:Select_leng
IF "%XX%"=="" GOTO :select_leng2
IF /I "%SMG%" EQU "mario1" (
	ECHO !header%XX%!
	SET found=1
	GOTO :Select_ModSMG1
)
IF /I "%SMG%" EQU "mario2" (
	ECHO !header%XX%!
	SET found=2
	GOTO :Select_ModSMG2
)
GOTO :AutoTry

:select_leng2
SET /A num=1
CLS
ECHO Ver. 1.1!NL!
ECHO %Box_T%
ECHO     I    Super Mario Galaxy Riivolution to WBFS    I
ECHO     I        Contact: viktormax3@gmail.com         I
ECHO     I                                              I
ECHO     I     Selecione el idioma para el Script       I
ECHO     I     Choice a lenguaje for the Script         I
ECHO     I                                              I
ECHO %Box_B%!NL!
IF %Spanish% EQU yes (
	SET /A num=num+1 >NUL
	ECHO %num%^) ES: Espa¤ol
)
IF %English% EQU yes (
	SET /A num=num+1 >NUL
	ECHO %num%^) EN: English
)
IF %Deutsch% EQU yes (
	SET /A num=num+1 >NUL
	ECHO %num%^) DE: Deutsch
)
ECHO.
SET /P sel_leng= -^> 
SET /A num=1
IF defined Spanish (
	SET /A num=num+1
	IF "%sel_leng%" EQU "%num%" GOTO :ES_STRINGS
	IF /I "%sel_leng%" EQU "ES" GOTO :ES_STRINGS
	IF /I "%sel_leng%" EQU "Espa¤ol" GOTO :ES_STRINGS
	IF /I "%sel_leng%" EQU "Espanol" GOTO :ES_STRINGS
)     
IF defined English (
	SET /A num=num+1
	IF "%sel_leng%" EQU "%num%" GOTO :EN_STRINGS
	IF /I "%sel_leng%" EQU "EN" GOTO :EN_STRINGS
	IF /I "%sel_leng%" EQU "English" GOTO :EN_STRINGS
)
IF defined Deutsch (
	SET /A num=num+1
	IF "%sel_leng%" EQU "%num%" GOTO :DE_STRINGS
	IF /I "%sel_leng%" EQU "DE" GOTO :DE_STRINGS
	IF /I "%sel_leng%" EQU "Deutsch" GOTO :DE_STRINGS
)
ECHO  
GOTO :Select_leng


:drag_drop
FOR /F %%i in ('%WITPATH% ID6 "%~1"') do SET GAMEID=%%i
IF /I %gameid% EQU rmge01 SET isoFile="%~1"& SET SMG=Mario1
IF /I %gameid% EQU rmgp01 SET isoFile="%~1"& SET SMG=Mario1
IF /I %gameid% EQU rmgj01 SET isoFile="%~1"& SET SMG=Mario1
IF /I %gameid% EQU sb4e01 SET isoFile="%~1"& SET SMG=Mario2
IF /I %gameid% EQU sb4j01 SET isoFile="%~1"& SET SMG=Mario2
IF /I %gameid% EQU sb4p01 SET isoFile="%~1"& SET SMG=Mario2
GOTO :Select_leng

:AutoTry
CLS
ECHO !header%XX%!
ECHO %Box_T%
ECHO !AutoTry%XX%!
ECHO %Box_B%
SET found_1=0
SET found_2=0
FOR /F "usebackq delims==" %%1 in (`%witpath% flist -n rmge01`) do SET isousa1=%%1& SET found_1=1
FOR /F "usebackq delims==" %%2 in (`%witpath% flist -n rmgp01`) do SET isopal1=%%3& SET found_1=1
FOR /F "usebackq delims==" %%3 in (`%witpath% flist -n rmgj01`) do SET isojap1=%%2& SET found_1=1
FOR /F "usebackq delims==" %%4 in (`%witpath% flist -n sb4e01`) do SET isousa2=%%4& SET found_2=2
FOR /F "usebackq delims==" %%6 in (`%witpath% flist -n sb4j01`) do SET isojap2=%%6& SET found_2=2
FOR /F "usebackq delims==" %%5 in (`%witpath% flist -n sb4p01`) do SET isopal2=%%5& SET found_2=2

:iso_found
CLS
ECHO !header%XX%!
SET /A found=found_1+found_2
IF %found% EQU 0 (
COLOR C0
ECHO !NoGameFound%XX%!
PAUSE >NUL
EXIT
) ELSE (
color E0
ECHO %Box_T%
IF %found% LEQ 2 (
ECHO !Found1%XX%!
)
IF %found% EQU 3 (
ECHO !Found2%XX%!
)
ECHO     I                                              I
IF %found% EQU 1 (
ECHO     I             Super Mario Galaxy 1             I
)
IF %found% EQU 2 (
ECHO     I             Super Mario Galaxy 2             I
)
IF %found% EQU 3 (
ECHO     I  Super Mario Galaxy 1  Super Mario Galaxy 2  I
)
ECHO !Found3%XX%!
)

ECHO !Game_Disp%XX%!
ECHO.
SET /A num=1 
IF defined isousa1 (
	SET /A num=num+1 >NUL
	ECHO %num%^) SMG1 USA
)
IF defined isopal1 (
	SET /A num=num+1 >NUL
	ECHO %num%^) SMG1 PAL
)
IF defined isojap1 (
	SET /A num=num+1 >NUL
	ECHO %num%^) SMG1 JAP
)
IF defined isousa2 (
	SET /A num=num+1 >NUL
	ECHO %num%^) SMG2 USA
)
IF defined isopal2 (
	SET /A num=num+1 >NUL
	ECHO %num%^) SMG2 PAL
)
IF defined isojap2 (
	SET /A num=num+1 >NUL
	ECHO %num%^) SMG2 JAP
)
ECHO.
SET /P sel_iso=Elige una opcion: 
SET /A num=1
IF defined isousa1 (
	SET /A num=num+1
	IF "%sel_iso%" EQU "%num%" SET isoFile="%isousa1%"& GOTO :Select_ModSMG1
	IF /I "%sel_iso%" EQU "smg1 usa" SET isoFile="%isousa1%"& GOTO :Select_ModSMG1
)     
IF defined isopal1 (
	SET /A num=num+1
	IF "%sel_iso%" EQU "%num%" SET isoFile="%isopal1%"& GOTO :Select_ModSMG1
	IF /I "%sel_iso%" EQU "smg1 pal" SET isoFile="%isopal1%"& GOTO :Select_ModSMG1
)
IF defined isojap1 (
	SET /A num=num+1
	IF "%sel_iso%" EQU "%num%" SET isoFile="%isojap1%"& GOTO :Select_ModSMG1
	IF /I "%sel_iso%" EQU "smg1 jap" SET isoFile="%isojap1%"& GOTO :Select_ModSMG1
)
IF defined isousa2 (
	SET /A num=num+1
	IF "%sel_iso%" EQU "%num%" SET isoFile="%isousa2%"& GOTO :Select_ModSMG2
	IF /I "%sel_iso%" EQU "smg2 usa" SET isoFile="%isousa2%"& GOTO :Select_ModSMG2
)     
IF defined isopal2 (
	SET /A num=num+1
	IF "%sel_iso%" EQU "%num%" SET isoFile="%isopal2%"& GOTO :Select_ModSMG2
	IF /I "%sel_iso%" EQU "smg2 pal" SET isoFile="%isopal2%"& GOTO :Select_ModSMG2
)
IF defined isojap2 (
	SET /A num=num+1
	IF "%sel_iso%" EQU "%num%" SET isoFile="%isojap2%"& GOTO :Select_ModSMG2
	IF /I "%sel_iso%" EQU "smg2 jap" SET isoFile="%isojap2%"& GOTO :Select_ModSMG2
)
ECHO  
GOTO :iso_found

:Select_ModSMG1
REM For verify free space to apply smg1 mods
SET have_mod=
SET free=
FOR /F "usebackq tokens=3" %%s IN (`DIR C:\ /-C /-O /W`) DO (
    SET free=%%s
)
SET /a free=%free:~0,-7% >nul
IF %free% leq %req% (
CLS
COLOR C0
echo %free%
ECHO !Header%XX%!
ECHO !NoSpace1%XX%!
PAUSE >NUL
COLOR E0
GOTO :Select_ModSMG1
)
color E0
IF EXIST "./%riivdir%kmg.riiv" (
	SET KMGX01=Kaizo Mario Galaxy
	SET have_mod=yes
)
IF EXIST "./%riivdir%tgs.riiv" (
	SET TGSX01=SMG1 The Green Stars
	SET have_mod=yes
)
REM IF EXIST "./namemod.riiv" (
	REM SET ID_MOD=Internal_Name        to add other mods 
	REM SET have_mod=yes
REM )
ECHO.
ECHO !Mod_Disp%XX%!
SET /A num=1
IF NOT DEFINED have_mod (
cls
COLOR C0
ECHO !Header%XX%!
ECHO !NoMods%XX%!
PAUSE >NUL
exit
)
ECHO.
IF DEFINED KMGX01 (
	SET /A num=num+1 >NUL
	ECHO %num%^) %KMGX01%
)
IF DEFINED TGSX01 (
	SET /A num=num+1 >NUL
	ECHO %num%^) %TGSX01%
)
REM IF DEFINED ID_MOD (
	REM SET /A num=num+1 >NUL         to add other mods 
	REM ECHO %num%^) %ID_MOD%
REM )
ECHO 0^) !GoBack%XX%! 
ECHO.
SET /A num=1
SET /P sel_mod=!SelMod%XX%!
IF defined KMGX01 (
	SET /A num=num+1
	IF /I "%sel_mod%" EQU "%num%" GOTO :KMGX01
	IF /I "%sel_mod%" EQU "%KMGX01%" GOTO :KMGX01
)     
IF defined TGSX01 (
	SET /A num=num+1
	IF /I "%Sel_mod%" EQU "%num%" GOTO :TGSX01
	IF /I "%Sel_mod%" EQU "%TGSX01%" GOTO :TGSX01
)
IF "%sel_mod%" EQU "0" GOTO :autotry
IF /I "%sel_mod%" EQU "!GoBack%XX%!" GOTO :autotry
REM IF EXIST "./namemod.riiv" (
	REM SET ID_MOD=Internal_Name        to add other mods 
	REM SET have_mod=yes
REM )
ECHO  
GOTO :Select_ModSMG1

:Select_ModSMG2
REM For verify free space to apply smg2 mods
SET have_mod=
SET free=
FOR /F "usebackq tokens=3" %%s IN (`DIR C:\ /-C /-O /W`) DO (
    SET free=%%s
)
SET /a free=%free:~0,-7% >nul
IF %free% leq %req2% (
CLS
COLOR C0
echo %free%
ECHO !Header%XX%!
ECHO !NoSpace2%XX%!
PAUSE >NUL
COLOR E0
GOTO :Select_ModSMG2
)
color E0
IF EXIST "./%riivdir%nmg.riiv" (
	SET NMGX01=Neo Mario Galaxy
	SET have_mod2=yes
)
IF EXIST "./%riivdir%smg64hs.riiv" (
	SET M64XHS=SMG64 Holiday Special
	SET have_mod2=yes
)
IF EXIST "./%riivdir%ngs.riiv" (
	SET NGSX01=SMG2 The New Green Star
	SET have_mod2=yes
)
ECHO.
ECHO !Mod_Disp%XX%!
SET /A num=1
IF NOT DEFINED have_mod2 (
cls
COLOR C0
ECHO !Header%XX%!
ECHO !NoMods%XX%!
PAUSE >NUL
exit
)
ECHO.
IF DEFINED NMGX01 (
	SET /A num=num+1 >NUL
	ECHO %num%^) %NMGX01%
)
IF DEFINED M64XHS (
	SET /A num=num+1 >NUL
	ECHO %num%^) %M64XHS%
)
IF DEFINED NGSX01 (
	SET /A num=num+1 >NUL
	ECHO %num%^) %NGSX01%
)
REM IF DEFINED ID_MOD (
	REM SET /A num=num+1 >NUL        to add other mods 
	REM ECHO %num%^) %ID_MOD%
REM )
ECHO 0^) !GoBack%XX%!
ECHO.
SET /A num=1
SET /P sel_mod=!SelMod%XX%!
IF defined NMGX01 (
	SET /A num=num+1
	IF "%sel_mod%" EQU "%num%" GOTO :NMGX01
	IF /I "%sel_mod%" EQU "%NMGX01%" GOTO :NMGX01
)     
IF defined M64XHS (
	SET /A num=num+1
	IF "%Sel_mod%" EQU "%num%" GOTO :M64XHS
	IF /I "%Sel_mod%" EQU "%M64XHS%" GOTO :M64XHS
)
IF defined NGSX01 (
	SET /A num=num+1 
	IF "%Sel_mod%" EQU "%num%" GOTO :NGSX01
	IF /I "%Sel_mod%" EQU "%NGSX01%" GOTO :NGSX01
)
IF "%sel_mod%" EQU "0" GOTO :autotry
IF /I "%sel_mod%" EQU "!GoBack%XX%!" GOTO :autotry
REM IF defined ID_MOD (
	REM SET /A num=num+1 
	REM IF /I "%Sel_mod%" EQU "%num%" GOTO :ID_MOD           to add other mods
	REM IF /I "%Sel_mod%" EQU "%ID_MOD%" GOTO :ID_MOD
REM )
ECHO  
GOTO :Select_ModSMG2

:NMGX01
SET name_mod=%NMGX01%
SET ModDir=.\nmg
SET ModRiiv=./%riivdir%nmg.riiv
FOR /F %%4 in ('%witpath% ID6 %isoFile% ') do SET GAMEID=%%4
IF %GAMEID% EQU SB4E01 SET REG=USA& SET ID=NMGE01& SET TMD=NMGE& SET GCT=yes
IF %GAMEID% EQU SB4P01 SET REG=PAL& SET ID=NMGP01& SET TMD=NMGP& SET GCT=yes
IF %GAMEID% EQU SB4J01 SET REG=JAP& SET ID=NMGJ01& SET TMD=NMGJ& SET GCT=yes
GOTO :set_strings2

:M64XHS
SET name_mod=%M64XHS%
SET ModDir=.\smg64hs
SET ModRiiv=./%riivdir%smg64hs.riiv
FOR /F %%4 in ('%witpath% ID6 %isoFile% ') do SET GAMEID=%%4
IF %GAMEID% EQU SB4E01 SET REG=USA& SET ID=M64EHS& SET TMD=HS6E& SET GCT=yes
IF %GAMEID% EQU SB4P01 SET REG=PAL& SET ID=M64PHS& SET TMD=HS6P& SET GCT=yes
IF %GAMEID% EQU SB4J01 (
ECHO !RegModNo%XX%!
PAUSE >NUL
GOTO :Select_ModSMG2
)
REM IF %GAMEID% EQU SB4J01 SET REG=JAP& SET ID=M64JHS& SET TMD=M64J
GOTO :set_strings2

:NGSX01
SET name_mod=%NGSX01%
SET ModDir=.\ngs
SET ModRiiv=./%riivdir%ngs.riiv
FOR /F %%4 in ('%witpath% ID6 %isoFile% ') do SET GAMEID=%%4
IF %GAMEID% EQU SB4E01 SET REG=USA& SET ID=NGSE01& SET TMD=NGSE& SET GCT=no
IF %GAMEID% EQU SB4P01 SET REG=PAL& SET ID=NGSP01& SET TMD=NGSP& SET GCT=no
IF %GAMEID% EQU SB4J01 SET REG=JAP& SET ID=NGSJ01& SET TMD=NGSJ& SET GCT=no
GOTO :set_strings2

:KMGX01
SET name_mod=%KMGX01%
SET ModDir=.\kmg
SET ModRiiv=./%riivdir%kmg.riiv
FOR /F %%4 in ('%witpath% ID6 %isoFile% ') do SET GAMEID=%%4
IF %GAMEID% EQU RMGE01 SET REG=USA& SET ID=KMGE01& SET TMD=KMGE& SET GCT=yes
IF %GAMEID% EQU RMGP01 SET REG=PAL& SET ID=KMGP01& SET TMD=KMGP& SET GCT=no
IF %GAMEID% EQU RMGJ01 (
ECHO !RegModNo%XX%!
PAUSE >NUL
GOTO :Select_ModSMG1
)
GOTO :set_strings2

:TGSX01
SET name_mod=%TGSX01%
SET ModDir=.\tgs
SET ModRiiv=./%riivdir%tgs.riiv
FOR /F %%4 in ('%witpath% ID6 %isoFile% ') do SET GAMEID=%%4
IF %GAMEID% EQU RMGE01 SET REG=USA& SET ID=TGSE01& SET TMD=TGSE& SET GCT=no
IF %GAMEID% EQU RMGP01 SET REG=PAL& SET ID=TGSP01& SET TMD=TGSP& SET GCT=no
IF %GAMEID% EQU RMGJ01 SET REG=JAP& SET ID=TGSJ01& SET TMD=TGSJ& SET GCT=no
GOTO :set_strings2


REM :ID_MOD
REM SET name_mod=%ID_MOD%
REM SET ModDir=.\FolderMod
REM SET ModRiiv=./%riivdir%NameMod.riiv
REM FOR /F %%4 in ('%witpath% ID6 %isoFile% ') do SET GAMEID=%%4
REM IF %GAMEID% EQU SB4E01 SET REG=USA& SET ID=ID_MOD& SET TMD=TMD_MOD  	| 	EQU SB4E01=SMG2 or  EQU RMGE01=SMG1 | SET GCT=N for mempatches yes or no
REM IF %GAMEID% EQU SB4P01 SET REG=PAL& SET ID=ID_MOD& SET TMD=TMD_MOD  	|	EQU SB4P01=SMG2 or  EQU RMGP01=SMG1 | SET GCT=N for mempatches yes or no
REM IF %GAMEID% EQU SB4J01 SET REG=JAP& SET ID=ID_MOD& SET TMD=TMD_MOD  	|	EQU SB4J01=SMG2 or  EQU RMGJ01=SMG1 | SET GCT=N for mempatches yes or no
REM GOTO :set_strings2

:Build_Mod
COLOR A0
CLS
ECHO !header%XX%!
ECHO !Build1%XX%!
IF EXIST "%ModDir%" (
	del /s /q "%ModDir%" >NUL
)
%RARPATH% x -y -ed %ModRiiv% >NUL
ECHO !Build2%XX%!
SET WORKDIR=.\%ID%-UNPACK
IF EXIST "%WORKDIR%\" (
	rd /S /Q "%WORKDIR%" >NUL 
)
REM for extract original game
%WITPATH% extract -1p %isoFile% --DEST "%WORKDIR%" --psel data -ovv
REM For Memory patches 
IF /I %GCT% EQU yes GOTO :MemoryPatch
IF /I %GCT% EQU no GOTO :CopyMod

:MemoryPatch
CLS
ECHO !header%XX%!
IF EXIST "./gct/%ID%.gct" (
	ECHO !YesGCT_%XX%!
    %SZSPATH% patch "%WORKDIR%/sys/main.dol" --add-sect "./gct/%ID%.gct" -ovv
) ELSE (
	COLOR C0
	ECHO !NoGCT_%XX%!
PAUSE >NUL
GOTO :AutoTry
)

:CopyMod
ECHO !CopyMod%XX%!
REM to copy mod files, banner and saveiconbanner
xcopy "%ModDir%\*" "%WORKDIR%/files" /E /Y >NUL
xcopy ".\banner\%name_mod%.bnr" "%WORKDIR%/files/opening.bnr" /E /Y >NUL
xcopy ".\banner\%name_mod%.arc" "%WORKDIR%/files/ObjectData/SaveIconBanner.arc" /E /Y >NUL
CLS
ECHO !header%XX%!
ECHO !BuildMod%XX%!
REM for build modded game
SET moddedFile=%name_mod% %REG%.wbfs
IF EXIST ".\%moddedFile%" (
	del /s /q ".\%moddedFile%" >NUL
)
%WITPATH% copy "%WORKDIR%" --DEST ".\%moddedFile%" -ovv
ECHO %Box_T%
ECHO !Clear%XX%!
ECHO %Box_B%
rd /S /Q "%WORKDIR%" "%ModDir%"

CLS
REM for change ticket TMD ID6 and internal name
ECHO !header%XX%!
ECHO !ChangeID_%XX%!
%WITPATH% EDIT --id  %ID%  ".\%moddedFile%" >NUL
ECHO !ChangeTMD_%XX%!
%WITPATH% EDIT --tt-id  %TMD%  ".\%moddedFile%" >NUL
ECHO !Internal%XX%!
IF "%name_mod%" EQU "%NMGX01%" (
ECHO     I               %name_mod%               I
)
IF "%name_mod%" EQU "%M64XHS%" (
ECHO     I            %name_mod%             I
)
IF "%name_mod%" EQU "%NGSX01%" (
ECHO     I           %name_mod%            I
)
IF "%name_mod%" EQU "%TGSX01%" (
ECHO     I            %name_mod%             I
)
IF "%name_mod%" EQU "%KMGX01%" (
ECHO     I              %name_mod%              I
)
REM IF "%name_mod%" EQU "%ID_MOD%"  (
REM ECHO     I           %name_mod%            I
REM )				for ECHO name_mod at center
ECHO %Box_B%
%WITPATH% EDIT --name  "%name_mod%"  ".\%moddedFile%" >NUL
ECHO.
ECHO %Box_T%
ECHO !Result%XX%!
ECHO %Box_B%
%WITPATH% id -l -n %ID%
ECHO %Box_T%
ECHO !ReqOther%XX%!
ECHO %Box_B%
CHOICE /C YN /M "!y_n%XX%!"
IF %errorlevel% EQU 1 GOTO :autotry
IF %errorlevel% EQU 2 (
CLS
ECHO !header%XX%!
ECHO !Ready%XX%!
PAUSE >NUL
EXIT 
)


:ES_STRINGS
SET XX=ES
SET HeaderES=Ver. 1.1!NL!^
!NL!^
%Box_T%!NL!^
    I    Super Mario Galaxy Riivolution to WBFS    I!NL!^
    I                                              I!NL!^
    I   Contacto: viktormax3@gmail.com             I!NL!^
    I   Agradecimientos a el team de Wiimms        I!NL!^
    I   Por los binarios wit y wstrt utilizados    I!NL!^
%Box_B%!NL!

SET AutoTryES=    I     Detectando juegos automaticamente...     I
SET NoGameFoundES=    I        Imagen de disco no encontrada.        I!NL!^
    I * Verifique que se encuentre en esta carpeta I!NL!^
    I * Verifique que sea el juego correcto        I!NL!^
    I                                              I!NL!^
    I    Presione cualquier tecla para salir.      I!NL!

SET Found1ES=    I               Juego encontrado               I
SET Found2ES=    I              Juegos encontrados              I
SET Found3ES=    I                                              I!NL!^
    I    * Seleccione su juego                     I!NL!^
    I    * Seleccione el mod que desea aplicar.    I!NL!^
%Box_B%!NL!

SET Game_DispES=Juegos disponibles: 
SET Mod_DispES=Mods Disponibles: 
SET SelModES=Elige un Mod: 
SET GoBackES=Regresar
SET RegModNoES=Mod no disponible para esta region actualmente

SET NoSpace1ES=%Box_T%!NL!^
    I  Hay poco espacio para modificar este juego  I!NL!^
    I       Se necesitan %F% de espacio libre      I!NL!^
    I                                              I!NL!^
    I         Clickea aqui para reintentar         I!NL!^
%Box_B%!NL!

SET NoSpace2ES=%Box_T%!NL!^
    I  Hay poco espacio para modificar este juego  I!NL!^
    I       Se necesitan %F2% de espacio libre      I!NL!^
    I                                              I!NL!^
    I         Clickea aqui para reintentar         I!NL!^
%Box_B%!NL!

SET NoModsES=%Box_T%!NL!^
    I            No se encontraron mods            I!NL!^
    I          Verifique que se encuentren         I!NL!^
    I          en la carpeta "%riivdir%"          I!NL!^
%Box_B%!NL!
	
SET Build1ES=%Box_T%!NL!^
    I            Descomprimiendo el mod^^!           I!NL!^
    I            Esto llevara un tiempo.           I!NL!^
%Box_B%!NL!


SET Build2ES=%Box_T%!NL!^
    I           Descomprimiendo el juego^^!          I!NL!^
    I            Esto llevara un tiempo.           I!NL!^
%Box_B%!NL!

SET CopyModES=%Box_T%!NL!^
    I       Copiando archivos modificados...       I!NL!^
    I           Esto llevara un tiempo.            I!NL!^
%Box_B%!NL!

SET BuildModES=%Box_T%!NL!^
    I     Creando imagen de disco modificada...    I!NL!^
    I           Esto llevara un tiempo.            I!NL!^
%Box_B%!NL!

SET ClearES=    I       Limpiando archivos temporales...       I
SET ResultES=    I                  Resultado:                  I
SET ReqOtherES=    I           Desea aplicar otro mod?            I

	
SET ReadyES=%Box_T%!NL!^
    I                    Listo^^!                    I!NL!^
    I              Presione cualquier              I!NL!^
    I               tecla para salir...            I!NL!^
%Box_B%!NL!

SET y_nES=Presione Y para Si, N para No.
GOTO :Select_leng

:ES_STRINGS2
SET YesGCT_ES=%Box_T%!NL!^
    I        Aplicando parche de memoria           I!NL!^
    I            Modificando main.dol              I!NL!^
%Box_B%!NL!

SET NoGCT_ES=%Box_T%!NL!^
    I                    ERROR                     I!NL!^
    I                                              I!NL!^
    I          %ID%.GCT No encontrado^^!           I!NL!^
    I       Asegurese de que el archivo .gct       I!NL!^
    I         este en la carpeta 'gct' y           I!NL!^
    I        tenga el nombre %ID%.GCT            I!NL!^
%Box_B%!NL!

SET ChangeID_ES=%Box_T%!NL!^
    I         Imagen de disco Region %REG%           I!NL!^
    I     Se cambiara el ID de %GAMEID% a %ID%     I!NL!^
%Box_B%!NL!

SET ChangeTMD_ES=%Box_T%!NL!^
    I         Imagen de disco Region %REG%           I!NL!^
    I          Se cambiara el TMD a %TMD%           I!NL!^
%Box_B%!NL!


SET InternalES=%Box_T%!NL!^
    I         Imagen de disco Region %REG%           I!NL!^
    I        Se cambiara el nombre interno a       I

GOTO :Build_Mod

:EN_STRINGS
SET XX=EN
REM Lineas en ingles
GOTO :Select_leng

:EN_STRINGS2
REM Lineas en ingles 2
GOTO :Build_Mod

:DE_STRINGS
SET XX=DE
REM Lineas en aleman
GOTO :Select_leng

:DE_STRINGS2
REM Lineas en aleman 2
GOTO :Build_Mod

:set_strings2
IF /I %XX% EQU ES GOTO :ES_STRINGS2
IF /I %XX% EQU EN GOTO :EN_STRINGS2
IF /I %XX% EQU DE GOTO :DE_STRINGS2