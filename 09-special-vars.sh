#!/bin/bash/

echo "all variables passed to the script : $@"
echo "number of variables passed to the script : $#"
echo "present script name : $0"
echo "user present dir : $PWD"
echo "user home dir : $HOME"
echo "current process instance id : $$"
sleep 10 &
echo "last process instance of background command: $!"