:: Bienvenidos a mi desastre
:: Made In Venezuela
:: By ViktorMax3
:: set encode to OEM 850 first
@echo off
SET version=Ver. 1.2
CHCP 850 >NUL
COLOR A0
SET NameG=Super Mario Galaxy
TITLE %NameG% Riivolution to WBFS
MODE con: cols=56 lines=45
CD "%~dp0"
SET WSTRT=bin\wstrt
SET WIT=bin\wit
SET RAR=bin\rar
SET Md5=bin\Md5 -c
SET RM=bin\rm -rf
SET BG=bin\bg
SET WGET=bin\wget
SET Plus=SET /A Num=Num+1
SET CFG=.\config.bat
IF EXIST %CFG% (
	CALL %CFG%
)
SET Clear=".\Clear.bat"
IF EXIST %Clear% (
	ECHO Wait...
	CALL %Clear%
	%RM% %Clear%
)
%BG% CURSOR 0
SET RiivDir=.\riiv_mods\
SET Deutsch=Yes
SET English=Yes
SET Spanish=Yes
SET Mod11=%RiivDir%kmg.riiv
SET Mod12=%RiivDir%tgs.riiv
SET Mod21=%RiivDir%nmg.riiv
SET Mod22=%RiivDir%m64.riiv
SET Mod23=%RiivDir%ngs.riiv
SET Mod24=%RiivDir%tll.riiv
SET Mod25=%RiivDir%mg1.riiv
SET Mod26=%RiivDir%mg2.riiv
SET BoxT=    /==============================================\
SET BoxE=    I                                              I
SET BoxB=    \==============================================/
SET req1=800
SET req2=400
SET f_1=8GB
SET f_2=4GB
SET On=SETlocal enableDelayedExpansion
SET Off=SETlocal disableDelayedExpansion
:: Script need turn off-on delayedexpansion
%On%
SET NL=^



:SelectLang
IF DEFINED XX (
	GOTO :%XX%Strings
)
COLOR E0
SET Num=1
CLS
:: If you add another language in this echo need a edit SET Num=11 in label :ClickLang to SET Num=12 
ECHO %version%!NL!
ECHO %BoxT%
ECHO     I    %NameG% Riivolution to WBFS    I
ECHO     I        Contact: viktormax3@gmail.com         I
ECHO %BoxE%
ECHO     I     W„hlen Sie die Sprache fr das Skript    I
ECHO     I     Select the language for the Script       I
ECHO     I     Seleccione el idioma para el Script      I
ECHO %BoxB%!NL!
IF %Deutsch%==Yes (
	%Plus%
	ECHO %Num%^) Deutsch
)
IF %English%==Yes (
	%Plus%
	ECHO %Num%^) English
)
IF %Spanish%==Yes (
	%Plus%
	ECHO %Num%^) Espa¤ol
)

:ClickLang
CALL :BGFunc
SET Num=11
IF %Deutsch%==Yes (
	%Plus%
	IF "%Row%"=="%Num%" (
		GOTO :DEStrings
	)
)
IF %English%==Yes (
	%Plus%
	IF "%Row%"=="%Num%" (
		GOTO :ENStrings
	)
)
IF %Spanish%==Yes (
	%Plus%
	IF "%Row%"=="%Num%" (
		GOTO :ESStrings
	)
)
GOTO :clickLang

:ResetVar
SET E1=
SET P1=
SET J1=
SET E2=
SET P2=
SET J2=
SET F1=
SET F2=
SET GCT=
SET RMGE=
SET RMGP=
SET RMGJ=
SET SB4E=
SET SB4P=
SET SB4J=
SET GOTO=
SET Down=
SET GameID=
SET KMGX01=
SET TGSX01=
SET NMGX01=
SET M64X01=
SET NGSX01=
SET TLLX01=
SET MG1X01=
SET MG2X01=
exit /b

:Magic
CLS
SET SMG=
SET Found=
::reset variables due have changes before start script
IF "%ResetVar%"=="1" (
	CALL :ResetVar
)
SET ResetVar=1
:: %~1 variable are cleaned after progress script
IF NOT DEFINED Droped (
	SET Droped=%~1
)
IF "%Droped%" NEQ "" (
	%WIT% LS -Hr "%Droped%" | findstr /i "RMGE01 RMGP01 RMGJ01 SB4E01 SB4P01 SB4J01" >NUL && (
		COLOR A0
		ECHO Drag and Drop file
		%WIT% LS -Hr "%Droped%"
		%BG% SLEEP 1500
		SET DropDir=Yes
	) || (
		COLOR C0
		ECHO Invalid Drag and Drop
		SET DropDir=No
		%BG% SLEEP 1500
	)
) ELSE (
	SET DropDir=No
)
:: WIT are bugged no set many errors to %errorlevel%, partial fix: findstr correct files to filter no compatible drag and drop
CLS
COLOR A0
ECHO !Header%XX%!
ECHO %BoxT%
ECHO !AutoTry%XX%!
ECHO %BoxB%
IF NOT EXIST %CFG% (
	SET EXT=wbfs
	SET Banner=yes
	SET CheckMd5=yes
	SET Server=Gdrive
	ECHO :: NO EDIT MANUALLY> %CFG%
	ECHO :Settings>> %CFG%
	ECHO SET XX=!XX!>> %CFG%
	ECHO SET EXT=!EXT!>> %CFG%
	ECHO SET Banner=!Banner!>> %CFG%
	ECHO SET CheckMd5=!CheckMd5!>> %CFG%
	ECHO SET Server=!Server!>> %CFG%
)
IF "%DropDir%"=="Yes" (
	SET folder="%Droped%"
)
IF "%DropDir%"=="No" (
	SET folder=".\\"
)
SET WitFlist=%WIT% flist -r %folder% --rdepth 5 -n
FOR /F "delims==" %%1 in ('%WitFlist% RMGE01') do SET E1=%%1& SET F1=1+& SET RMGE=1+
FOR /F "delims==" %%2 in ('%WitFlist% RMGP01') do SET P1=%%2& SET F1=1+& SET RMGP=1+
FOR /F "delims==" %%3 in ('%WitFlist% RMGJ01') do SET J1=%%3& SET F1=1+& SET RMGJ=1+
FOR /F "delims==" %%4 in ('%WitFlist% SB4E01') do SET E2=%%4& SET F2=2+& SET SB4E=1+
FOR /F "delims==" %%5 in ('%WitFlist% SB4P01') do SET P2=%%5& SET F2=2+& SET SB4P=1+
FOR /F "delims==" %%6 in ('%WitFlist% SB4J01') do SET J2=%%6& SET F2=2+& SET SB4J=1+
SET /A Detected=%RMGE%%RMGP%%RMGJ%%SB4E%%SB4P%%SB4J%0
SET /A Found=%F1%%F2%0
IF "%Found%"=="0" (
	GOTO :NoGame
)
IF "%Detected%" GEQ "2" (
	GOTO :IsoFound
)
SET /A Found=%F1%%F2%0
IF "%Found%"=="1" (
	IF DEFINED E1 SET IsoFile="%E1%"
	IF DEFINED P1 SET IsoFile="%P1%"
	IF DEFINED J1 SET IsoFile="%J1%"
	SET SMG=1
)
IF "%Found%"=="2" (
	IF DEFINED E2 SET IsoFile="%E2%"
	IF DEFINED P2 SET IsoFile="%P2%"
	IF DEFINED J2 SET IsoFile="%J2%"
	SET SMG=2
)
GOTO :VerifySpace

:EchoHeader
CLS
SET Num=1
ECHO !Header%XX%!
COLOR E0
ECHO %BoxT%
IF "%Found%" LEQ "2" (
	ECHO !Found1%XX%!
)
IF "%Found%"=="3" (
	ECHO !Found2%XX%!
)
ECHO %BoxE%
IF "%Found%" LEQ "2" (
	ECHO     I             %NameG% %Found%             I
)
IF "%Found%"=="3" (
	ECHO     I  %NameG% 1  %NameG% 2  I
)
ECHO !Found3%XX%!
EXIT /b

:IsoFound
CALL :EchoHeader
ECHO !GameDisp%XX%!
ECHO.
IF DEFINED E1 (
	%Plus%
	ECHO %Num%^) SMG1 USA
)
IF DEFINED P1 (
	%Plus%
	ECHO %Num%^) SMG1 PAL
)
IF DEFINED J1 (
	%Plus%
	ECHO %Num%^) SMG1 JAP
)
IF DEFINED E2 (
	%Plus%
	ECHO %Num%^) SMG2 USA
)
IF DEFINED P2 (
	%Plus%
	ECHO %Num%^) SMG2 PAL
)
IF DEFINED J2 (
	%Plus%
	ECHO %Num%^) SMG2 JAP
)
ECHO.
ECHO R^) !Refresh%XX%!
ECHO S^) !GoCfg%XX%!
ECHO.
ECHO !ClickOption%XX%!
:ClickGame
CALL :BGFunc
SET Num=21
IF DEFINED E1 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET IsoFile="%E1%"
		SET SMG=1
	)
)
IF DEFINED P1 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET IsoFile="%P1%"
		SET SMG=1
	)
)
IF DEFINED J1 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET IsoFile="%J1%"
		SET SMG=1
	)
)
IF DEFINED E2 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET IsoFile="%E2%"
		SET SMG=2
	)
)
IF DEFINED P2 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET IsoFile="%P2%"
		SET SMG=2
	)
)
IF DEFINED J2 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET IsoFile="%J2%"
		SET SMG=2
	)
)
IF "%SMG%" NEQ "" (
	GOTO :VerifySpace
)
%Plus%
IF "%Row%"=="%Num%" (
	GOTO :Magic
)
%Plus%
IF "%Row%"=="%Num%" (
	GOTO :Config
)
GOTO :ClickGame

:VerifySpace
SET HaveMod%SMG%=
FOR /F "tokens=3" %%s in ('DIR %~d0\ /-C /-O /W') do (
	SET free=%%s
)
SET free=%free:~0,-7% >NUL
IF %free% LEQ !req%SMG%! (
	CLS
	COLOR C0
	ECHO %free%
	ECHO !Header%XX%!
	ECHO !NoSpace%SMG%%XX%!
	GOTO :ClickSpace
)
COLOR E0
GOTO :EchoModCaller

:ClickSpace
CALL :BGFunc
IF %Row% GTR 11 (
	IF %Row% LSS 16 (
		GOTO :VerifySpace
	)
)
GOTO :ClickSpace

:SetMod
COLOR E0
IF "%SMG%"=="1" (
	IF %Down% EXIST "%Mod11%" (
		SET KMGX01=Kaizo Mario Galaxy
		SET HaveMod1=Yes
	)
	IF %Down% EXIST "%Mod12%" (
		SET TGSX01=SMG1 The Green Stars
		SET HaveMod1=Yes
	)
)
IF "%SMG%"=="2" (
	IF %Down% EXIST "%Mod21%" (
		SET NMGX01=Neo Mario Galaxy
		SET HaveMod2=Yes
	)
	IF %Down% EXIST "%Mod22%" (
		SET M64X01=SMG64 Holiday Special
		SET HaveMod2=Yes
	)
	IF %Down% EXIST "%Mod23%" (
		SET NGSX01=SMG2 The New Green Star
		SET HaveMod2=Yes
	)
	IF %Down% EXIST "%Mod24%" (
		SET TLLX01=SMG2 The Lost Levels
		SET HaveMod2=Yes
	)
	IF %Down% EXIST "%Mod25%" (
		SET MG1X01=Super Mayro Galaxy
		SET HaveMod2=Yes
	)
	IF %Down% EXIST "%Mod26%" (
		SET MG2X01=Super Mayro Galaxy Twoad
		SET HaveMod2=Yes
	)
)
:: IF "%SMG%"=="N" (
	:: IF %Down% EXIST ".\namemod.riiv" (
		:: SET ID_MOD=Internal_Name
		:: SET HaveMod%SMG%=Yes
	:: )
::)
EXIT /b

:EchoMod
IF DEFINED KMGX01 (
	%Plus%
	ECHO %Num%^) %KMGX01%
)
IF DEFINED TGSX01 (
	%Plus%
	ECHO %Num%^) %TGSX01%
)
IF DEFINED NMGX01 (
	%Plus%
	ECHO %Num%^) %NMGX01%
)
IF DEFINED TLLX01 (
	%Plus%
	ECHO %Num%^) %TLLX01%
)
IF DEFINED NGSX01 (
	%Plus%
	ECHO %Num%^) %NGSX01%
)
IF DEFINED M64X01 (
	%Plus%
	ECHO %Num%^) %M64X01%
)
IF DEFINED MG1X01 (
	%Plus%
	ECHO %Num%^) %MG1X01%
)
IF DEFINED MG2X01 (
	%Plus%
	ECHO %Num%^) %MG2X01%
)
:: IF DEFINED ID_MOD (
	:: %Plus%
	:: ECHO %Num%^) %ID_MOD%
:: )
IF "%NUM%"=="1" (
	CLS
	ECHO !Header%XX%!
	COLOR A0
	ECHO %BoxT%
	ECHO !AllMods%XX%!
	ECHO %BoxB%
	%BG% SLEEP 2500 >NUL
	GOTO :Magic
)
EXIT /b

:EchoModCaller
SET GOTO=
CALL :EchoHeader
CALL :SetMod
IF /I "!HaveMod%SMG%!" NEQ "Yes" (
	CLS
	COLOR E0
	ECHO !Header%XX%!
	ECHO %BoxT%
	ECHO !NoMods%XX%!
	ECHO %BoxE%
	%BG% print !DownExit%XX%!
	ECHO %BoxB%
	CALL :DownExit
	GOTO :!GOTO!
)
ECHO !ModDisp%XX%!
ECHO.
CALL :EchoMod
ECHO.
ECHO D^) !DownMod%XX%!
IF "%Detected%" GEQ "2" (
	ECHO R^) !GoBack%XX%!
) ELSE (
	ECHO S^) !GoCfg%XX%!
)
ECHO X^) !Exit%XX%!
ECHO.
ECHO !ClickOption%XX%!
GOTO :ClickModCaller

:ClickMods
CALL :BGFunc
SET Num=21
IF DEFINED KMGX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=KMGX01
	)
)
IF DEFINED TGSX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=TGSX01
	)
)
IF DEFINED NMGX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=NMGX01
	)
)
IF DEFINED TLLX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=TLLX01
	)
)
IF DEFINED NGSX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=NGSX01
	)
)
IF DEFINED M64X01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=M64X01
	)
)
IF DEFINED MG1X01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=MG1X01
	)
)
IF DEFINED MG2X01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=MG2X01
	)
)
EXIT /b

:ClickModCaller
CALL :ClickMods
%Plus%
IF "%Row%"=="%Num%" (
	SET GOTO=DownMods
)
%Plus%
IF "%Detected%" GEQ "2" (
	IF "%Row%"=="%Num%" (
		SET GOTO=Magic
	)
) ELSE (
	IF "%Row%"=="%Num%" (
		SET GOTO=Config
	)
)
%Plus%
IF "%Row%"=="%Num%" (
	EXIT
)
IF DEFINED GOTO (
	GOTO :%GOTO%
)
GOTO :ClickModCaller

:DownMods
CALL :EchoHeader
CALL :ResetVar
ECHO !SelMod%XX%!
ECHO.
SET Down=NOT
CALL :SetMod
CALL :EchoMod
ECHO.
ECHO R^) !GoBack%XX%!
:ClickDown
CALL :ClickMods
%Plus%
IF "%Row%"=="%Num%" (
	SET GOTO=Magic
)
IF DEFINED GOTO (
	SET GOTO=
	GOTO :%GOTO%
)
GOTO :ClickDown

:Config
ECHO Configuraciones
ECHO Proximamente
pause
goto :magic

:NoGame
:: Agregar aqui un retry y salir en caso de que se necesite para no forzar la salida 
CLS
ECHO !Header%XX%!
COLOR C0
ECHO %BoxT%
ECHO !NoGameFound%XX%!
ECHO %BoxB%
PAUSE >NUL
EXIT

:: Super Mario Galaxy 1 MODS
:KMGX01
SET ModID=KMG
SET NameMod=%KMGX01%
SET ModName=    I              %NameMod%              I
SET Md5sum=0A10D5690375FB24AA81149C13C1F69C
IF DEFINED DOWN (
	SET DropBox=AACb04fuPlg9H1VG4jRYZk4Ha
	SET Gdrive=1U-J3WKqj6cUsBEzwVgKk5G3nthVlkY8U
GOTO :GenericDown
)
GOTO :GenericSet

:TGSX01
SET ModID=TGS
SET NameMod=%TGSX01%
SET ModName=    I            %NameMod%             I
SET Md5sum=BEE78D7664EA8C1625B261AAE622483F
IF DEFINED DOWN (
	SET DropBox=AABhquMqqj-QVfVVAFgld67ma
	SET Gdrive=14tV91noGAK6E1FE8V3tXT-WRfeUmdc9q
GOTO :GenericDown
)
GOTO :GenericSet

:: Super Mario Galaxy 2 MODS
:NMGX01
SET ModID=NMG
SET NameMod=%NMGX01%
SET ModName=    I               %NameMod%               I
SET Md5sum=61BA060C537AC05C27A719C657B088BA
IF DEFINED DOWN (
	SET DropBox=AAAi1RDwXS5k-d7zFE2htPc0a
	SET Gdrive=1w5QexmlJvs9RL7V3ZptR_MO7jBbLs7y2
GOTO :GenericDown
)
SET GCT=Yes
GOTO :GenericSet

:M64X01
SET ModID=M64
SET NameMod=%M64X01%
SET ModName=    I            %NameMod%             I
SET Md5sum=4FBD0EE4181CD02DFA1E8E605EF75AE1
IF DEFINED DOWN (
	SET DropBox=AAC_5nt_Zz1K0aMQ2B6fRc_6a
	SET Gdrive=1K8S946TlMnyJYJAriltpQ1GONik-FjfN
GOTO :GenericDown
)
SET GCT=Yes
GOTO :GenericSet

:NGSX01
SET ModID=NGS
SET NameMod=%NGSX01%
SET ModName=    I           %NameMod%            I
SET Md5sum=D1F1713EE94076F2DE4AD700AE2C76AB
IF DEFINED DOWN (
	SET DropBox=AAAAybY9pPkfa9hpa73JW9wpa
	SET Gdrive=1fjiHOSgBpg0sXybBsoC5y9YN2Z_RLG3I
GOTO :GenericDown
)
GOTO :GenericSet

:TLLX01
SET ModID=TLL
SET NameMod=%TLLX01%
SET ModName=    I             %NameMod%             I
SET Md5sum=1BAC43B1AA2016B3C83742D771837EC7
IF DEFINED DOWN (
	SET DropBox=AAB5L7DDess9r6hykGMu53dfa
	SET Gdrive=1aYeP1rC8TiCOKWFIutAX9vC0t4BCxv5O
GOTO :GenericDown
)
::SET GCT=Yes
GOTO :GenericSet

:MG1X01
SET ModID=MG1
SET NameMod=%MG1X01%
SET ModName=    I              %NameMod%              I
SET Md5sum=2EA854CBDFE07AB04C710AA78AEB3E4E
IF DEFINED DOWN (
	SET DropBox=AABAWYFs3DeNMUyQlwzndI_Ba
	SET Gdrive=1N54aRxUri3m_L9hDQNvU_Z167S5w34cn
GOTO :GenericDown
)
GOTO :GenericSet

:MG2X01
SET ModID=MG2
SET NameMod=%MG2X01%
SET ModName=    I           %NameMod%           I
SET Md5sum=57ED1678FB9FC166AD814B2D99C08CD6
IF DEFINED DOWN (
	SET DropBox=AAC-zR-EYuiqdHgX_63YyjMja
	SET Gdrive=16iRd_ZSqy6c_C_jI1235OHx1hes3Iw-C
GOTO :GenericDown
)
GOTO :GenericSet

:GenericDown
::Checar esta funcion con delayed expansion para evitar que se muestre
:: que se descargo correctamente cuando se reintenta la descarga fallida
:: En Call md5 crear una variable para ser verificada y omitir mostrar 
:: !md5good%xx%! usando !variable! en lugar de %variable% 

SET GdriveLink=https://www.googleapis.com/drive/v3/filesmamalo/%GDrive%?alt=media^^^&key=AIzaSyDljREoinbY9bSTw4pGNVqoU1RpkG9edK8
SET DropBoxLink=https://dropbox.com/sh/33bnoa9u49z3grm/%DropBox%/%ModID%.riiv?dl=1
CLS
IF NOT EXIST %RiivDir% (
	MD %RiivDir%
)
ECHO !Header%XX%!
COLOR A0
ECHO %BoxT%
ECHO !Downloading%XX%!
ECHO %BoxE%
ECHO %ModName%
ECHO %BoxB%
ECHO.
SET ModRiiv="%RiivDir%%ModID%.riiv.temp"
%WGET% --no-check-certificate "!%Server%Link!" -O %ModRiiv% -q --show-progress -t 3 && (
	CALL :Md5Func
	MOVE %ModRiiv% "%RiivDir%%ModID%.riiv" >NUL
	ECHO %BoxT%
	ECHO !Md5Good%XX%!
	ECHO %BoxB%
) || (
	%RM% %ModRiiv% >NUL
	%BG% SLEEP 2500 >NUL
	ECHO ALGO SALIO MAL eliminando archivo temporal
)
IF DEFINED BUILD (
		SET BUILD=
		SET DOWN=
		GOTO :%ModID%X01
)
IF NOT DEFINED GOTO (
	%BG% SLEEP 2500 >NUL
	GOTO :DownMods
)
GOTO :%GOTO%

:GenericSet
SET GameID=
FOR /F %%4 in ('%WIT% ID %IsoFile%') do SET GameID=%%4
IF "%GameID%"=="" (
	GOTO :NoGame
)
SET ModRiiv="%RiivDir%%ModID%.riiv"
SET ID=%ModID%%GameID:~3,3%
SET ModDir=.\%ModID%
SET TMD=%ID:~0,4%
IF "%ID:~3,1%"=="E" SET REG=USA
IF "%ID:~3,1%"=="P" SET REG=PAL
IF "%ID:~3,1%"=="J" SET REG=JAP
::To set specific reg of mod cheat
IF "%GCT%"=="" (
	IF %ID%==KMGE01 SET GCT=Yes
) ELSE (
	SET GCT=No
)
IF %ID%==KMGJ01 GOTO :NoModReg
IF %ID%==TLLJ01 GOTO :NoModReg
IF %ID%==MG1J01 GOTO :NoModReg
IF %ID%==MG2J01 GOTO :NoModReg
SET WorkDir=.\%ID%-FST
SET ModdedFile=".\%NameMod% [%ID%]\%ID%.%EXT%"
CALL :Md5Func
IF DEFINED GOTO (
	SET BUILD=Yes
	GOTO :%GOTO%
)
SET BUILD=
ECHO %RM% "%ModDir%" "%WorkDir%">> %Clear%
GOTO :%XX%Strings2

:Md5Func
SET GOTO=
IF /I "%CheckMd5%"=="Yes" (
	CLS
	ECHO !Header%XX%!
	ECHO %BoxT%
	ECHO !Md5Check%XX%!
	ECHO %BoxB%
	ECHO.
	%Md5%%Md5sum% %ModRiiv% || (
		CLS
		COLOR E0
		ECHO !Header%XX%!
		ECHO %BoxT%
		ECHO !Md5Bad%XX%!
		ECHO %BoxE%
		%BG% print !DownExit%XX%!
		ECHO %BoxB%
		CALL :DownExit
	)
)
EXIT /b

:DownExit
CALL :BGFunc
IF %Row%==13 (
	IF %Col% LSS 26 (
		IF %Col% GTR 4 (
			%RM% %ModRiiv% >NUL
			SET DOWN=NOT
			IF DEFINED ModID (
				SET GOTO=%ModID%X01
			) ELSE (
				SET GOTO=DownMods
			)	
		)
	)
	IF %Col% GTR 29 (
		IF %Col% LSS 51 (
			SET GOTO=Magic
		)
	)
)
IF DEFINED GOTO (
	EXIT /b
)
GOTO :DownExit

:NoModReg
COLOR C0
CLS
%BoxT%
ECHO !RegModNo%XX%!
%BoxB%
%BG% SLEEP 1500 >NUL
GOTO :Magic

:Extract
COLOR A0
CLS
ECHO !Header%XX%!
ECHO !Build1%XX%!
%RAR% x -y -ed %ModRiiv% >NUL
ECHO !Build2%XX%!
:: for extract original game
%WIT% X %IsoFile% -PqD "%WorkDir%" --psel data
ECHO.
:: For Memory patches
IF /I %GCT%==Yes (
	GOTO :GCT_Patch
)
IF /I %GCT%==XML (
	GOTO :XML_Patch
)
IF /I %GCT%==No (
	GOTO :BuildMod
)

:GCT_Patch
CLS
ECHO !Header%XX%!
IF EXIST ".\gct\%ID%.gct" (
	ECHO !YesGCT_%XX%!
	%WSTRT% patch "%WorkDir%\sys\main.dol" --add-sect ".\gct\%ID%.gct" -oPq
) ELSE (
	COLOR C0
	ECHO !NoGCT_%XX%!
	PAUSE >NUL
	GOTO :Magic
)
GOTO :BuildMod

:XML_Patch
:: para aplicar XML aun no lo termino 

:BuildMod
:: Evaluar una copia inversa para hacer cola de aplicar mods con una sola descompresion de wbfs
:: to copy mod files, banner and saveiconbanner
ECHO !CopyMod%XX%!
xcopy "%ModDir%\*" "%WorkDir%\files" /E /Y >NUL
IF /I "%Banner%"=="Yes" (
	IF EXIST ".\banner\%ModID%.*" (
		ECHO %BoxT%
		ECHO !BannerCopy%XX%!
		ECHO %BoxB%
		%BG% SLEEP 2500 >NUL
		xcopy ".\banner\%ModID%.bnr" "%WorkDir%\files\opening.bnr" /E /Y
		xcopy ".\banner\%ModID%.arc" "%WorkDir%\files\ObjectData\SaveIconBanner.arc" /E /Y
	) ELSE (
		ECHO %BoxT%
		ECHO !NoBanner%XX%!
		ECHO %BoxB%
		%BG% SLEEP 2500 >NUL
	)
)
CLS
ECHO !Header%XX%!
ECHO !BuildMod%XX%!
IF EXIST %ModdedFile% (
	%RM% %ModdedFile% >NUL
)
:: for build modded game
%WIT% CP "%WorkDir%" -PqD %ModdedFile%
ECHO.
ECHO %BoxT%
ECHO !Clear%XX%!
ECHO %BoxB%
CALL %Clear%
%RM% %Clear%
CLS
:: for change ticket TMD ID and internal name
ECHO !Header%XX%!
ECHO !ChangeID_%XX%!
ECHO %ModName%
ECHO %BoxB%
%WIT% ED --id %ID% --name "%NameMod%" --tt-id %TMD% %ModdedFile% >NUL
ECHO.
ECHO %BoxT%
ECHO !ReqOther%XX%!
COLOR E0
%BG% print !YesNo%XX%!
ECHO %BoxB%
ECHO.
ECHO %BoxT%
ECHO !Result%XX%!
ECHO %BoxB%
ECHO.
%WIT% LS --time off -lH %ModdedFile%

:ClickYN
CALL :BGFunc
IF %Row%==20 (
	IF %Col% LSS 26 (
		IF %Col% GTR 4 (
			GOTO :Magic
		)
	)
	IF %Col% GTR 29 (
		IF %Col% LSS 51 (
			CLS
			COLOR A0
			ECHO !Header%XX%!
			ECHO !Ready%XX%!
			:ClickNo
			CALL :BGFunc
			IF %Row% GTR 10 (
				IF %Row% LSS 14 (
					EXIT
				)
			)
			GOTO :ClickNo
		)
	)
)
GOTO :ClickYN

:BGFunc
%BG% MOUSE >NUL
SET /A "Row=%ErrorLevel% >> 0x10" >NUL
SET /A "Col=%ErrorLevel% & 0xFFFF" >NUL
exit /b

:ESStrings
SET XX=ES
SET HeaderES=%version%!NL!^
!NL!^
%BoxT%!NL!^
    I    %NameG% Riivolution a WBFS.    I!NL!^
%BoxE%!NL!^
    I   Contacto: viktormax3@gmail.com             I!NL!^
    I   Agradecimientos a el team de Wiimms        I!NL!^
    I   Por los binarios wit y wstrt utilizados    I!NL!^
%BoxB%!NL!

SET ClickOptionES=Clickea una opcion
SET AutoTryES=    I     Detectando juegos automaticamente...     I
SET NoGameFoundES=    I        Imagen de disco no encontrada.        I!NL!^
    I * Verifique que se encuentre en esta carpeta I!NL!^
    I * Verifique que sea el juego correcto        I!NL!^
%BoxE%!NL!^
    I    Presione cualquier tecla para salir.      I

SET Found1ES=    I               Juego encontrado               I
SET Found2ES=    I              Juegos encontrados              I
SET Found3ES=%BoxE%!NL!^
    I    1^) Seleccione su juego                    I!NL!^
    I    2^) Seleccione el mod que desea aplicar.   I!NL!^
%BoxB%!NL!

SET DownSelect=%BoxE%!NL!^
    I    Seleccione el mod que desea descargar.     I!NL!^
%BoxB%!NL!

SET GameDispES=Juegos disponibles:
SET ModDispES=Mods Disponibles:
SET SelModES=Elige un Mod:
SET DownModES=Descargar Mods
SET RefreshES=Buscar de nuevo
SET GoBackES=Volver
Set GoCfgES=Ajustes
SET ExitES=Salir
SET NoSpace1ES=%BoxT%!NL!^
    I  Hay poco espacio para modificar este juego  I!NL!^
    I       Se necesitan %F_1% de espacio libre      I!NL!^
%BoxE%!NL!^
    I         Clickea aqui para reintentar         I!NL!^
%BoxB%!NL!

SET NoSpace2ES=%BoxT%!NL!^
    I  Hay poco espacio para modificar este juego  I!NL!^
    I       Se necesitan %F_2% de espacio libre      I!NL!^
%BoxE%!NL!^
    I         Clickea aqui para reintentar         I!NL!^
%BoxB%!NL!

SET NoModsES=    I            No se encontraron mods            I
SET RegModNoES=    I      Mod no disponible para esta region      I
SET DownloadingES=    I         Descargando Mod seleccionado         I
SET Md5GoodES=    I        Mod descargando correctamente.        I
SET AllModsES=    I     Tienes todos los mods de este juego.     I
SET Md5CheckES=    I        Verificando archivo del mod...        I
SET Md5BadES=    I            Este mod esta da¤ado :^(           I
SET BannerCopyES=    I       Agregando Banner personalizado...      I
SET NoBannerES=    I No hay Banner personalizado para este mod :^( I
SET DownExitES=E0 "    I" A0 "      Descargar      " E0 "I  I" C0 "       Volver        " E0 "I    "
SET Build1ES=%BoxT%!NL!^
    I            Descomprimiendo el mod^^!           I!NL!^
    I            Esto llevara un tiempo.           I!NL!^
%BoxB%!NL!


SET Build2ES=%BoxT%!NL!^
    I           Descomprimiendo el juego^^!          I!NL!^
    I            Esto llevara un tiempo.           I!NL!^
%BoxB%!NL!

SET YesGCT_ES=%BoxT%!NL!^
    I        Aplicando parche de memoria           I!NL!^
    I            Modificando main.dol              I!NL!^
%BoxB%!NL!

SET CopyModES=%BoxT%!NL!^
    I       Copiando archivos modificados...       I!NL!^
    I           Esto llevara un tiempo.            I!NL!^
%BoxB%!NL!

SET BuildModES=%BoxT%!NL!^
    I     Creando imagen de disco modificada...    I!NL!^
    I           Esto llevara un tiempo.            I!NL!^
%BoxB%!NL!

SET ClearES=    I       Limpiando archivos temporales...       I
SET ResultES=    I                  Resultado:                  I
SET ReqOtherES=    I           Desea aplicar otro mod?            I
SET ReadyES=%BoxT%!NL!^
    I                    Listo^^!                    I!NL!^
%BoxE%!NL!^
    I           Clickea aqui para salir.           I!NL!^
%BoxB%!NL!

GOTO :Magic

:ESStrings2
SET NoGCT_ES=%BoxT%!NL!^
    I                    ERROR                     I!NL!^
%BoxE%!NL!^
    I          %ID%.GCT No encontrado^^!           I!NL!^
    I       Asegurese de que el archivo .gct       I!NL!^
    I         este en la carpeta 'gct' y           I!NL!^
    I        tenga el nombre %ID%.GCT            I!NL!^
%BoxB%!NL!

SET ChangeID_ES=%BoxT%!NL!^
    I         Imagen de disco Region %REG%           I!NL!^
    I     Se cambiara el ID de %GameID% a %ID%     I!NL!^
    I          Se cambiara el TMD a %TMD%           I!NL!^
    I        Se cambiara el nombre interno a       I


SET YesNoES=E0 "    I" A0 "          Si         " E0 "I  I" C0 "          No         " E0 "I    "
GOTO :Extract

:ENStrings
SET XX=EN
SET HeaderEN=%version%!NL!^
!NL!^
%BoxT%!NL!^
    I    %NameG% Riivolution to WBFS.   I!NL!^
%BoxE%!NL!^
    I   Contact: viktormax3@gmail.com              I!NL!^
    I   Thanks to the Wiimms team                  I!NL!^
    I   For the wit and wstrt binaries used        I!NL!^
%BoxB%!NL!
SET ClickOptionEN=Click an option
SET AutoTryEN=    I       Detecting games automatically...       I
SET NoGameFoundEN=    I             Disk image not Found.            I!NL!^
    I * Verify that it is in this folder           I!NL!^
    I * Verify that it is the right game           I!NL!^
%BoxE%!NL!^
    I            Press any key to exit.            I


SET Found2EN=    I                 Games Found                  I
SET Found3EN=%BoxE%!NL!^
    I    1^) Select your game                       I!NL!^
    I    2^) Select the mod you want to apply.      I!NL!^
%BoxB%!NL!

SET GameDispEN=Games available:
SET ModDispEN=Available Mods:
SET SelModEN=Choose a Mod:
SET DownModEN=Download Mods
SET GoBackEN=Go back
Set GoCfgEN=Settings
SET ExitEN=Exit
SET RegModNoEN=Mod currently not available for this region
SET NoSpace1EN=%BoxT%!NL!^
    I    There is low space to modify this game    I!NL!^
    I           %F_1% of free space needed           I!NL!^
%BoxE%!NL!^
    I             Click here to retry.             I!NL!^
%BoxB%!NL!

SET NoSpace2EN=%BoxT%!NL!^
    I    There is low space to modify this game    I!NL!^
    I           %F_2% of free space needed           I!NL!^
%BoxE%!NL!^
    I             Click here to retry.             I!NL!^
%BoxB%!NL!

SET NoModsEN=    I                No mods Found                 I
SET RegModNoEN=    I      Mod not available for this region.      I
SET DownloadingEN=    I           Downloading Mod selected           I
SET AllModsEN=    I     You have all the mods of this game.      I
SET Md5CheckEN=    I             Checking mod file ...            I
SET Md5BadEN=    I            This mod is damaged :^(            I
SET BannerCopyEN=    I           Adding Custom Banner ...           I
SET NoBannerEN=    I  There is no custom Banner for this mod :^(   I
SET DownExitEN=E0 "    I" A0 "       Download      " E0 "I  I" C0 "        Exit         " E0 "I    "
SET Build1EN=%BoxT%!NL!^
    I            Decompressing the mod^^!            I!NL!^
    I           This will take a moment.           I!NL!^
%BoxB%!NL!

SET Build2EN=%BoxT%!NL!^
    I            Decompressing the game^^!           I!NL!^
    I           This will take a moment.           I!NL!^
%BoxB%!NL!

SET YesGCT_EN=%BoxT%!NL!^
    I            Applying memory patch             I!NL!^
    I             Modifying main.dol               I!NL!^
%BoxB%!NL!

SET CopyModEN=%BoxT%!NL!^
    I           Copying modified files...          I!NL!^
    I           This will take a moment.           I!NL!^
%BoxB%!NL!

SET BuildModEN=%BoxT%!NL!^
    I        Creating modified disk image...       I!NL!^
    I           This will take a moment.           I!NL!^
%BoxB%!NL!

SET ClearEN=    I          Cleaning temporary files...         I
SET ResultEN=    I                    Result:                   I
SET ReqOtherEN=    I        You want to apply another mod?        I
SET ReadyEN=%BoxT%!NL!^
    I                    Ready^^!                    I!NL!^
%BoxE%!NL!^
    I              Click here to exit.             I!NL!^
%BoxB%!NL!

GOTO :Magic

:ENStrings2
SET NoGCT_EN=%BoxT%!NL!^
    I                    ERROR                     I!NL!^
%BoxE%!NL!^
    I             %ID%.GCT Not Found^^!              I!NL!^
    I          Make sure the .gct file is          I!NL!^
    I             in the 'gct' folder              I!NL!^
    I           and has the name %ID%.GCT            I!NL!^
%BoxB%!NL!

SET ChangeID_EN=%BoxT%!NL!^
    I             %REG% Region Disk Image            I!NL!^
    I   ID will be changed from %GameID% to %ID%   I!NL!^
    I          TMD will be changed to %TMD%         I!NL!^
    I     The internal name will be changed to     I

SET YesNoEN=E0 "    I" A0 "         Yes         " E0 "I  I" C0 "          No         " E0 "I    "
GOTO :Extract

:DEStrings
ECHO Language is not yet available, help me to translate
ECHO Click anything
%BG% mouse >NUL
SET XX=
GOTO :SelectLang
::Clear up lines before translate
:: Deutsch lines
:: No Edit format
:: Example
:: SET Found1EN=    I                  Game Found                  I
:: SET VariableXX=4 spaces I   46 characters fill with spaces to center   I
:: Replace "variableXX" to "variableDE" or another first two letters of translated language like a PT, IT
SET XX=DE
GOTO :Magic

:DEStrings2
:: Deutsch lines 2
SET YesNoDE=E0 "    I" A0 "          Ja         " E0 "I  I" C0 "         Nein        " E0 "I    "
GOTO :Extract