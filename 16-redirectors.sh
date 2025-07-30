#!/bin/bash

USERID=$(id -u)
LOGS_FOLDER=/var/log/shell-script
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIME_STAMP=$(date +%F-%H:%M:%S)
#/var/log/shell-script/16-redirectors.sh-time
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log" 
mkdir -p $LOGS_FOLDER

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e " $R Run this script with root prevellege $N" | tee -a $LOG_FILE
    exit 1
fi    

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$R $2 installation is failed..check it.. $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$G $2 installation is success.. $N" | tee -a $LOG_FILE
    fi        
}

USAGE(){
    echo -e "$R USAGE:: sh 16-redirectors.sh package1 package2 ... $N" 
    exit 1
}

echo "Script started executing at: $TIME_STAMP" | tee -a $LOG_FILE

if [ $# -eq 0 ]
then
    USAGE
fi    

for package in $@
do
    dnf list installed $package -y &>> $LOG_FILE

    if [ $? -ne 0 ]
    then
        echo -e " $B $package is not installed..going to install it $N" | tee -a $LOG_FILE
        dnf install $package -y &>> $LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "$Y $package is already installed..nothing to do $N" | tee -a $LOG_FILE
    fi       
done    