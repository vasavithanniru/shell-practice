#!/bin/bash

FILE=file.txt

#Check if file is exist, if not then create it.

if [ -f $FILE ]
then 
    echo "$FILE is exist"
else
    echo "$FILE does not exist. Creating it now.."
    touch $FILE 
    echo "Hellow world" > $FILE
    echo "$FILE is created" 
fi       