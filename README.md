# Liferay-training

setup command 

tomcat start
tomcat stop

file tomcat.bat

@ECHO OFF
set arg1=%1
ECHO Congratulations! Start Apache tomcat.
cd /d D:\lifeRay\liferay-portal-7.1.3-ga4\tomcat-9.0.17\bin
if %arg1%==start start %arg1%up.bat
if %arg1%==shutdown start %arg1%.bat

before run internal command please setup  Environment variables point to folder included tomcat.bat

--------------------------
