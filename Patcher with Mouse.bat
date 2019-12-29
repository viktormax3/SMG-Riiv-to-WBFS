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
SET udec=bin\udec
SET "echo=%BG% print"
SET WGET=bin\wget
SET Plus=SET /A Num=Num+1
SET CFG=.\config.bat
IF EXIST %CFG% (
	CALL %CFG%
)
:: to clear files in the case of FC the script before build game
SET Clear=".\Clear.bat"
%BG% CURSOR 0
SET RiivDir=.\riiv_mods\
SET Deutsch=Yes
SET English=Yes
SET Spanish=Yes
SET BoxT=    /==============================================\
SET BoxE=    I                                              I
SET BoxB=    \==============================================/
SET req1=8192
SET req2=4096
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
SET Patch=
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
EXIT /B

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
	%WIT% LS -Hr "%Droped%" | findstr /i "\<RMG \<SB4" >NUL && (
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
IF EXIST %Clear% (
	ECHO.
	ECHO %BoxT%
	ECHO !Wait%XX%!
	ECHO %BoxB%
	CALL %Clear% && (
		%RM% %Clear%
	)
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
	SET Banner=Yes
	SET CheckMd5=Yes
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
IF "%Detected%" GEQ "2" (
	GOTO :IsoFound
)
IF "%Found%"=="0" (
	GOTO :NoGame
)
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
EXIT /B

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
:: Verify the free space to build mods
:: Fixed to disks over 999GB and space -1MB
SET GOTO=
Set len=
SET ReqS=!F_%SMG%!
FOR /F "tokens=3" %%x in ('DIR %~d0\ /-C /-O /W') do (
	SET "s=#%%x"
	SET free=%%x
)
FOR %%N in (32 16 8 4 2 1) do (
	if "!s:~%%N,1!" NEQ "" (
		SET /a "len+=%%N"
		SET "s=!s:~%%N!"
	)
)
IF %len% geq 10 (
		SET Unit=GB
		SET Space=%free:~0,1%
		IF %free:~0,-6% LEQ !req%SMG%! (
			CALL :NoSpace
	)
)
IF %len% LSS 10 (
	SET Space=%free:~0,3%
	IF %len% GTR 6 (
		SET Unit=MB
		CALL :NoSpace
	)
)
IF %len% LSS 7 (
	IF %len% GTR 3 (
		SET Unit=KB
		CALL :NoSpace
	)
)
IF %len% LSS 4 (
	SET Unit=Bytes
	CALL :NoSpace
)
IF DEFINED GOTO (
	GOTO :%GOTO%
)
COLOR E0
GOTO :EchoModCaller

:NoSpace
CLS
COLOR C0
ECHO !Header%XX%!
ECHO !NoSpace%XX%:XXX=%ReqS%!
ECHO !Space! !Unit!
GOTO :ClickSpace
EXIT /B

::Falta poner retry y volver
:ClickSpace
CALL :BGFunc
IF %Row% GTR 11 (
	IF %Row% LSS 16 (
		SET GOTO=VerifySpace
	)
)
IF DEFINED GOTO (
	EXIT /B
)
GOTO :ClickSpace

:SetMod
SET Num=0
COLOR E0
IF "%SMG%"=="1" (
	IF %Down% EXIST "%RiivDir%kmg.riiv" (
		SET KMGX01=Kaizo Mario Galaxy
		!Plus!
		ECHO !Num!^) !KMGX01!
	)
	IF %Down% EXIST "%RiivDir%tgs.riiv" (
		SET TGSX01=SMG1 The Green Stars
		!Plus!
		ECHO !Num!^) !TGSX01!
	)
)
IF "%SMG%"=="2" (
	IF %Down% EXIST "%RiivDir%nmg.riiv" (
		SET NMGX01=Neo Mario Galaxy
		!Plus!
		ECHO !Num!^) !NMGX01!
	)
	IF %Down% EXIST "%RiivDir%m64.riiv" (
		SET M64X01=SMG64 Holiday Special
		!Plus!
		ECHO !Num!^) !M64X01!
	)
	IF %Down% EXIST "%RiivDir%ngs.riiv" (
		SET NGSX01=SMG2 The New Green Star
		!Plus!
		ECHO !Num!^) !NGSX01!
	)
	IF %Down% EXIST "%RiivDir%tll.riiv" (
		SET TLLX01=SMG2 The Lost Levels
		!Plus!
		ECHO !Num!^) !TLLX01!
	)
	IF %Down% EXIST "%RiivDir%mg1.riiv" (
		SET MG1X01=Super Mayro Galaxy
		!Plus!
		ECHO !Num!^) !MG1X01!
	)
	IF %Down% EXIST "%RiivDir%mg2.riiv" (
		SET MG2X01=Super Mayro Galaxy Twoad
		!Plus!
		ECHO !Num!^) !MG2X01!
	)
)
IF "%Down%" NEQ "NOT" (
	IF "!NUM!"=="0" (
		CLS
		COLOR E0
		ECHO !Header%XX%!
		ECHO %BoxT%
		ECHO !NoMods%XX%!
		ECHO %BoxE%
		%ECHO% !DownExit%XX%!
		ECHO %BoxB%
		CALL :DownExit
		SET GOTO=!GOTO!
	)
) ELSE (
	IF "!NUM!"=="0" (
		CLS
		ECHO !Header%XX%!
		COLOR A0
		ECHO %BoxT%
		ECHO !AllMods%XX%!
		ECHO %BoxB%
		%BG% SLEEP 2500 >NUL
		SET GOTO=Magic
	)
)
::IF "%SMG%"=="%RiivDir%%IDMod%.riiv" (
	::	IF %Down% EXIST ".\namemod.riiv" (
		:: SET ID_MOD=Internal_Name
		:: !Plus!
		:: ECHO !Num!^) !MG2X01!
	::	)
::)
EXIT /B

:EchoModCaller
SET GOTO=
CALL :EchoHeader
ECHO !ModDisp%XX%!
ECHO.
CALL :SetMod
IF DEFINED GOTO (
	SET GOTO=
	GOTO :%GOTO%
)
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
IF DEFINED M64X01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=M64X01
	)
)
IF DEFINED NGSX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=NGSX01
	)
)
IF DEFINED TLLX01 (
	%Plus%
	IF "%Row%"=="%Num%" (
		SET GOTO=TLLX01
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
EXIT /B

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
	SET GOTO=
	GOTO :%GOTO%
)
GOTO :ClickModCaller

:DownMods
CALL :EchoHeader
CALL :ResetVar
SET Down=NOT
ECHO !SelMod%XX%!
ECHO.
CALL :SetMod
IF DEFINED GOTO (
	SET GOTO=
	GOTO :%GOTO%
)
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
SET Patch=XML
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
SET Patch=XML
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
SET Patch=XML
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
IF "%api%"=="" (
	echo begin 0666 api!NL!^
M/V%%L=#UM961I829K97D]04EZ85-Y1^&QJ4D5O:6YB63EB4U1W-'^^!'3E9Q;U4Q!NL!^
)4G^^!K1SEE9$LX!NL!^
`!NL!^
end!NL!>>asd
	%udec% asd>Nul
	FOR /F %%u in ('type api') do set "api=%%u"
	%RM% api asd
)
SET "GdriveLink=https://www.googleapis.com/drive/v3/files/%GDrive%%api%"
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
	IF "!BAD!"=="Yes" (
		%RM% %ModRiiv%
		SET BAD=
		GOTO :!GOTO!
	)
	MOVE %ModRiiv% "%RiivDir%%ModID%.riiv" >NUL
	ECHO %BoxT%
	ECHO !Md5Good%XX%!
	ECHO %BoxB%
) || (
	%RM% %ModRiiv%
	%BG% SLEEP 2500 >NUL
	ECHO Algo salio mal eliminando archivo temporal
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
:: agregar una verificacion de conexion a internet mediante ping a el servidor de descarga seleccionado 
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
IF "%Patch%"=="" (
	IF %ID%==KMGE01 (
		SET Patch=GCT
	) ELSE (
	SET Patch=No
	)
)
:: Any mod work with Korean game :(
IF "%ID:~3,1%"=="K" GOTO :NoModReg
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
ECHO %RM% "%ModDir%" "%WorkDir%" > %Clear%
ECHO IF EXIST ".\%NameMod% [%ID%]\*.tmp\" ( >> %Clear%
ECHO	%RM% ".\%NameMod% [%ID%]\" >> %Clear%
ECHO	) >> %Clear%
GOTO :%XX%Strings2

:Md5Func
SET GOTO=
IF "%CheckMd5%"=="Yes" (
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
		%ECHO% !DownExit%XX%!
		ECHO %BoxB%
		CALL :DownExit
		SET BAD=Yes
	)
)
EXIT /B

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
	EXIT /B
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
ECHO %BoxT%
ECHO !Build1%XX%!
ECHO !Wait%XX%!
ECHO %BoxB%
ECHO.
%RAR% x -y -ed %ModRiiv% >NUL
ECHO %BoxT%
ECHO !Build2%XX%!
ECHO !Wait%XX%!
ECHO %BoxB%
ECHO.
:: for extract original game
%WIT% X %IsoFile% -PqD "%WorkDir%" --psel data
ECHO.
:: For Memory patches
IF %Patch%==No (
	GOTO :BuildMod
)

:GenPatch
IF "%Patch%"=="GCT" (
	SET PatchFile=.\%Patch%\%ID%.%Patch%
)
IF "%Patch%"=="XML" (
	SET PatchFile=.\%Patch%\%ModID%.%Patch%
)
SET NoGCT_Replace=
SET NoGCT_Replace=!NoGCT_%XX%:NNN=%Patch%!
IF "%Patch%"=="GCT" (
	SET NoGCT_Replace=!NoGCT_Replace:MMMMMM=%ID%!
)
IF "%Patch%"=="XML" (
	SET NoGCT_Replace=!NoGCT_Replace:MMMMMM=   %ModID%!
)
%RM% "%PatchFile%.tmp" >nul
CLS
ECHO !Header%XX%!
IF EXIST "%PatchFile%" (
	ECHO !YesGCT_%XX%!
	IF %PATCH%==GCT (
		%WSTRT% patch "%WorkDir%\sys\main.dol" --add-sect "%PatchFile%" -oPq
	) ELSE (
		FOR /F "tokens=* delims=" %%f in ('type %PatchFile%') do CALL :ReplaceXML "%%f"
		%WIT% DOLPATCH "%WorkDir%\sys\main.dol" "NEW=TEXT,0x80001800,1800" "XML=%PatchFile%.tmp" -o >> log_xml.txt
	)
) ELSE (
	COLOR C0
	ECHO !NoGCT_Replace!
	PAUSE >NUL
	GOTO :Magic
)
GOTO :BuildMod

:ReplaceXML
:: inspired on nsmbw patcher xml replacer i used to set various modes of same mod
:: XML1 and XML2 not defined at moment 
SET GenXML=%*
SET ModXML=!GenXML:%REG%=memory!
IF DEFINED XML1 (
	SET ModXML=!ModXML:%XML1%=memory!
)
IF DEFINED XML2 (
	SET ModXML=!ModXML:%XML2%=memory!
)
FOR /F "tokens=* delims=" %%m in ('ECHO %ModXML%') do ECHO %%~m>>%PatchFile%.tmp
SET XML1=
SET XML2=
SET ModXML=
SET GenXML=
EXIT /b

:BuildMod
:: Evaluar una copia inversa para hacer cola, la descompresion depende de ram y cpu y la copia de la velocidad del disco
:: to copy mod files, banner and saveiconbanner
ECHO %BoxT%
ECHO !CopyMod%XX%!
ECHO !Wait%XX%!
ECHO %BoxB%
ECHO.
xcopy "%ModDir%\*" "%WorkDir%\files" /E /Y >NUL
IF "%Banner%"=="Yes" (
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
ECHO %BoxT%
ECHO !BuildMod%XX%!
ECHO !Wait%XX%!
ECHO %BoxB%
ECHO.
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
%ECHO% !YesNo%XX%!
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
			IF !Row! GTR 10 (
				IF !Row! LSS 14 (
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
EXIT /B

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

SET GameDispES=Juegos disponibles:
SET ModDispES=Mods Disponibles:
SET SelModES=Elige un Mod:
SET DownModES=Descargar Mods
SET RefreshES=Buscar de nuevo
SET GoBackES=Volver
Set GoCfgES=Ajustes
SET ExitES=Salir
SET NoSpaceES=%BoxT%!NL!^
    I  Hay poco espacio para modificar este juego  I!NL!^
    I       Se necesitan XXX de espacio libre      I!NL!^
%BoxE%!NL!^
    I         Clickea aqui para reintentar         I!NL!^
%BoxB%!NL!

SET NoModsES=    I            No se encontraron mods            I
SET RegModNoES=    I      Mod no disponible para esta region      I
SET DownSelectES=    I    Seleccione el mod que desea descargar.     I
SET DownloadingES=    I         Descargando Mod seleccionado         I
SET Md5GoodES=    I        Mod descargando correctamente.        I
SET AllModsES=    I     Tienes todos los mods de este juego.     I
SET Md5CheckES=    I        Verificando archivo del mod...        I
SET Md5BadES=    I            Este mod esta da¤ado :^(           I
SET BannerCopyES=    I       Agregando Banner personalizado...      I
SET NoBannerES=    I No hay Banner personalizado para este mod :^( I
SET WaitES=    I              Espere un momento.              I
SET DownExitES=E0 "    I" A0 "      Descargar      " E0 "I  I" C0 "       Volver        " E0 "I    "
SET YesNoES=E0 "    I" A0 "          Si         " E0 "I  I" C0 "          No         " E0 "I    "
SET Build1ES=    I            Descomprimiendo el mod^^!           I
SET Build2ES=    I           Descomprimiendo el juego^^!          I
SET CopyModES=    I       Copiando archivos modificados...       I
SET BuildModES=    I     Creando imagen de disco modificada...    I
SET ClearES=    I       Limpiando archivos temporales...       I
SET ResultES=    I                  Resultado:                  I
SET ReqOtherES=    I           Desea aplicar otro mod?            I
SET NoGCT_ES=%BoxT%!NL!^
    I                    ERROR                     I!NL!^
%BoxE%!NL!^
    I          MMMMMM.NNN No encontrado^^!           I!NL!^
    I       Asegurese de que el archivo .NNN       I!NL!^
    I         este en la carpeta 'NNN' y           I!NL!^
    I        tenga el nombre MMMMMM.NNN            I!NL!^
%BoxB%!NL!

SET YesGCT_ES=%BoxT%!NL!^
    I        Aplicando parche de memoria           I!NL!^
    I            Modificando main.dol              I!NL!^
%BoxB%!NL!

SET ReadyES=%BoxT%!NL!^
    I                    Listo^^!                    I!NL!^
%BoxE%!NL!^
    I           Clickea aqui para salir.           I!NL!^
%BoxB%!NL!

GOTO :Magic

:ESStrings2

SET ChangeID_ES=%BoxT%!NL!^
    I         Imagen de disco Region %REG%           I!NL!^
    I     Se cambiara el ID de %GameID% a %ID%     I!NL!^
    I          Se cambiara el TMD a %TMD%           I!NL!^
    I        Se cambiara el nombre interno a       I
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

SET Found1EN=    I                  Game Found                  I
SET Found2EN=    I                 Games Found                  I
SET Found3EN=%BoxE%!NL!^
    I    1^) Select your game                       I!NL!^
    I    2^) Select the mod you want to apply.      I!NL!^
%BoxB%!NL!

SET GameDispEN=Games available:
SET ModDispEN=Available Mods:
SET SelModEN=Choose a Mod:
SET DownModEN=Download Mods
SET RefreshEN=Search again
SET GoBackEN=Go back
Set GoCfgEN=Settings
SET ExitEN=Exit
SET NoSpaceEN=%BoxT%!NL!^
    I    There is low space to modify this game    I!NL!^
    I           XXX of free space needed           I!NL!^
%BoxE%!NL!^
    I             Click here to retry.             I!NL!^
%BoxB%!NL!

SET NoModsEN=    I                No mods Found                 I
SET RegModNoEN=    I      Mod not available for this region.      I
SET DownSelectEN=    I    Seleccione el mod que desea descargar.     I
SET DownloadingEN=    I           Downloading Mod selected           I
SET Md5GoodEN=    I        Mod descargando correctamente.        I
SET AllModsEN=    I     You have all the mods of this game.      I
SET Md5CheckEN=    I             Checking mod file ...            I
SET Md5BadEN=    I            This mod is damaged :^(            I
SET BannerCopyEN=    I           Adding Custom Banner ...           I
SET NoBannerEN=    I  There is no custom Banner for this mod :^(   I
SET WaitEN=    I                Wait a moment.                I
SET DownExitEN=E0 "    I" A0 "       Download      " E0 "I  I" C0 "        Exit         " E0 "I    "
SET YesNoEN=E0 "    I" A0 "         Yes         " E0 "I  I" C0 "          No         " E0 "I    "
SET Build1EN=    I            Decompressing the mod^^!            I
SET Build2EN=    I            Decompressing the game^^!           I
SET CopyModEN=    I           Copying modified files...          I
SET BuildModEN=    I        Creating modified disk image...       I
SET ClearEN=    I          Cleaning temporary files...         I
SET ResultEN=    I                    Result:                   I
SET ReqOtherEN=    I        You want to apply another mod?        I
SET NoGCT_EN=%BoxT%!NL!^
    I                    ERROR                     I!NL!^
%BoxE%!NL!^
    I             MMMMMM.NNN Not Found^^!            I!NL!^
    I          Make sure the .NNN file is          I!NL!^
    I             in the 'NNN' folder              I!NL!^
    I           and has the name MMMMMM.NNN        I!NL!^
%BoxB%!NL!

SET YesGCT_EN=%BoxT%!NL!^
    I            Applying memory patch             I!NL!^
    I             Modifying main.dol               I!NL!^
%BoxB%!NL!

SET ReadyEN=%BoxT%!NL!^
    I                    Ready^^!                    I!NL!^
%BoxE%!NL!^
    I              Click here to exit.             I!NL!^
%BoxB%!NL!

GOTO :Magic

:ENStrings2
SET ChangeID_EN=%BoxT%!NL!^
    I             %REG% Region Disk Image            I!NL!^
    I   ID will be changed from %GameID% to %ID%   I!NL!^
    I          TMD will be changed to %TMD%         I!NL!^
    I     The internal name will be changed to     I
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
