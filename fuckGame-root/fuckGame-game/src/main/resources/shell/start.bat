@echo off
echo BootDir:%cd%
set Boot_JAVA_HOME=
set Boot_Class=net.jueb.fuckGame.game.GameServerStart
set Boot_Class_Args=

rem =====setWindowStyle=====
:: color 2A
title %Boot_Class% %Boot_Class_Args%

set ROOT_HOME=.

rem =====customJavaHome=====
if "%Boot_JAVA_HOME%" == "" goto useSystemJavaHome
set JAVA_HOME=%Boot_JAVA_HOME%
:useSystemJavaHome

rem =====AppendJars=====
set Boot_CLASSPATH=
FOR %%F IN (%ROOT_HOME%\lib\*.jar) DO call :addcp %%F
goto extlibe
:addcp
SET Boot_CLASSPATH=%1;%Boot_CLASSPATH%
goto :eof
:extlibe

set CLASSPATH=.;%CLASSPATH%;%Boot_CLASSPATH%;%ROOT_HOME%\conf;%ROOT_HOME%\bin
set Jvm_Args=-Xms64m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=%ROOT_HOME%\heap.dump -Xloggc:%ROOT_HOME%\logs\gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps
echo Using JAVA_HOME: %JAVA_HOME%
echo Using CLASSPATH: %CLASSPATH%
echo Using Jvm_Args: %Jvm_Args%
echo Using Boot_Class: %Boot_Class%
echo Using Boot_Class_Args: %Boot_Class_Args%
java %Jvm_Args% %Boot_Class% %Boot_Class_Args%