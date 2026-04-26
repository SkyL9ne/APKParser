@if "%DEBUG%" == "" @echo OFF
@REM ##########################################################################
@REM
@REM  Gradle startup script for Windows
@REM
@REM ##########################################################################

@REM Set local scope for the variables with Windows NT shell
if "%OS%"=="Windows_NT" setlocal

@REM Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

@REM Find java.exe
if defined JAVA_HOME GOTO findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" GOTO init

ECHO.
ECHO ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
ECHO.
ECHO Please set the JAVA_HOME variable in your environment to match the
ECHO location of your Java installation.

GOTO fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" GOTO init

ECHO.
ECHO ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
ECHO.
ECHO Please set the JAVA_HOME variable in your environment to match the
ECHO location of your Java installation.

GOTO fail

:init
@REM Get command-line arguments, handling Windowz variants

if NOT "%OS%" == "Windows_NT" GOTO win9xME_args
if "%@eval[2+2]" == "4" GOTO 4NT_args

:win9xME_args
@REM Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" GOTO execute

set CMD_LINE_ARGS=%*
GOTO execute

:4NT_args
@REM Get arguments from the 4NT Shell from JP Software
set CMD_LINE_ARGS=%$

:execute
@REM Setup the command line

set CLASSPATH=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar

@REM Execute Gradle
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRADLE_OPTS% "-Dorg.gradle.appname=%APP_BASE_NAME%" -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %CMD_LINE_ARGS%

:end
@REM End local scope for the variables with Windows NT shell
if "%ERRORLEVEL%"=="0" GOTO mainEnd

:fail
REM Set variable GRADLE_EXIT_CONSOLE if you need the _script_ return code instead of
REM the _cmd.exe /c_ return code!
if  NOT "" == "%GRADLE_EXIT_CONSOLE%" exit 1
exit /B 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
