#!/bin/bash/

USERID=$(id u)

if [ $USERID -ne 0 ] 
then 
    echo " run with root privillege"
    exit1
fi

dnf list installed git -y

if [ $? -ne 0 ]
then
    echo "installing git"
    dnf install git -y
else
    echo "git is already installed" 
fi    


    
    