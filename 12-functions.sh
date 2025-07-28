#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Run with root privellege"
    exit 1
else
    echo "user is root"    
fi    

dnf installed git -y

if [ $? -ne 0 ]
