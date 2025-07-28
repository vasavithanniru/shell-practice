#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Run with root privellege"
    exit 1
else
    echo "user is root"    
fi    

dnf list installed git -y

if [ $? -ne 0 ]
then 
    echo "git is not installed..going to install.."
    dnf install git -y 
    if [ $? -ne 0 ]
        echo "git  installation is failed..check it.."
    else 
        echo "git installation is success.."  
    fi      
else
    echo "git is already installed..nothing to do.."
fi    