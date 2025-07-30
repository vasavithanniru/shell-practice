#!/in/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Run with root prevellege"
    exit 1
fi   

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 installation is failed..check it" 
        exit 1
    else
        echo "$2 installation is success"   
    fi     
}

#sh 15-loops.sh git mysql postfix ....
for package in $@ 
do
    dnf list installed $package -y

    if [ $? -ne 0 ]
    then 
        echo "$package is not installed.. going to intall it.."
        dnf install $package -y
        VALIDATE $? "$package"
    else
        echo "$package is already installed..Nothing to do.."    
    fi  
done

# dnf list installed mysql -y

# if [ $? -ne 0 ]
# then 
#     echo "MySQL is not installed.. going to install"
#     dnf install mysql -y
#     VALIDATE $? "MySQL"
# else
#     echo "MySQL is already installed.. Nothing to do"   
# fi     