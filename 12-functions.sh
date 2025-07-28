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
    if [ $1 -ne 0 ]
    then 
        echo "$2 installation is .... FAILED"
        exit 1
    else
        echo "$2 installation is .... SUCCESS"   
    fi     
}

dnf list installed git -y

if [ $? -ne 0 ]
then 
    echo "git is not installed..going to install.."
    dnf install git -y 
    VALIDATE $? "git"
else
    echo "git is already installed..nothing to do.."
fi  

dnf list installed mysql -y

if [ $? -ne 0 ] 
then
    echo "MySQL is not installed.. goint to install"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo "MySQL is already installed.. nothing to do"    
fi     