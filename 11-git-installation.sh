#!/bin/bash/

USERID=$(id u)

if [ $USERID -ne 0 ] 
then 
    echo " run with root privillege"
    exit1
fi

    
    