#!/bin/bash/

USERID=$(id -u)

if [ $USERID -ne 0 ] 
then 
    echo " run with root privillege"
    exit1
fi

dnf list installed git -y

if [ $? -ne 0 ]
then
    echo "git is not installed, goining to install git.."
    dnf install git -y

    if [ $? -ne 0 ]
    then 
        echo "git installation is not success.. check it..."
        exit 1
    else
        echo "git installation is success.."
    fi

else
    echo "git is already installed" 
fi    

dnf list installed mysql

if [ $? -ne 0 ]
then 
    echo "mysql is not installed, going to install.."
    dnf install mysqlll -y 

    if [ $? -ne 0 ]
    then 
        echo "Mysql Installation is failed, check it.."
        exit 1
    else
        echo "mysql installion is success.."    
else
    "mysql is already installed.."    

    
    