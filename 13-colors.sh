#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "run with root prevellege"
    exit 1
fi  

R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2  $R installation is..... FAILED $N..check it.."
        exit 1
    else
        echo -e "$2  $G installation is...   SUCCESS $N "    
    fi  
}
dnf list installed git

if [ $? -ne 0 ]
then
    echo "git in not installed.. going to install"
    dnf install git -y  
    VALIDATE $? "git"
else
    echo "git is already installed..Nothing to do"    
fi