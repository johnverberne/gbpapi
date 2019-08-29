rem ----------------------------
rem %1% ecoSystemService
rem %2% projectFile absolutePath
rem python:2.7
rem pcraster-4.1.0_x86-64
rem c:\python27\python

set NCM_WORKSPACE=/opt/nkmodel
set NCM_CONFIGURATION=/opt/nkmodel/NatuurlijkKapitaalModellen/environment/configuration/ncm.ini
rem python /opt/nkmodel/NatuurlijkKapitaalModellen/source/script/air_regulation.py /opt/nkmodel_scenario/project.ini

echo get last git commit for NatuurlijkKapitaalModellen
rem git -C $NCM_WORKSPACE/NatuurlijkKapitaalModellen log -1

rem copy result files to directory 
echo %6%
echo %5%
echo %4%

copy d:\opt\nkmodel\demo_results\* "%6%"
