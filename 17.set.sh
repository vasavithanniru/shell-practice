#!/bin/bash

set -e #setting automatic exit if we get error. instead of exit 1 cmd we can use set -e cmd.set -ex for debug

failure(){
    echo "failure at $1:$2"
}        

trap 'failure "$LINENO" "$BASH_COMMAND"' ERR  #ERR is the error signal
echo "Hi, This is success"
echoo "Hi, This is failed"
echo "Hi After fail"