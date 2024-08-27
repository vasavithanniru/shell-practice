#!/bin/bash/

echo "all variables passed to the script : $@"
echo "number of variables passed to the script : $#"
echo "present cript name : $0"
echo "user present dir : $PWD"
echo "user home dir : $HOME"
echo "current procss instance : $$"
sleep 10 &
echo "last process instance of background command: $!"