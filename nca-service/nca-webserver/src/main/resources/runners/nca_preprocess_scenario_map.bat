#!/bin/bash
# The scripts starts a docker file and runs a specific task with col2map and pcrcalc, after executing the docker instance is removed.
echo ----------------------
echo start col2map -S  $1 $2 --clone $3
echo ----------------------
echo col2map -S  $1 $2 --clone $3
echo ----------------------
echo start pcrcalc $5=cover\($4, $5\) 
echo ----------------------
echo test run to copy as new file
echo pcrcalc $6=cover\($4, $5\) 
echo keep this version
echo pcrcalc $5=cover\($4, $5\) 
echo ----------------------


