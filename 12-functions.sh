#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Run with root privellege"
    exit 1
# else
#     echo "user is root"    
fi    

VALIDATE(){
    if [ $? -ne 0 ]
    then 
        echo "git installation is .... FAILURE"
    else
        echo "git installation is .... SUCCESS"   
    fi     
}

dnf list installed git -y

if [ $? -ne 0 ]
then 
    echo "git is not installed..going to install.."
    dnf install git -y 
    VALIDATE     
else
    echo "git is already installed..nothing to do.."
fi    