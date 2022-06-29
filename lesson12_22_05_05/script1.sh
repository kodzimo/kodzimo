#! /bin/bash

if [[ $# -ne 2 ]]; then
    echo "Please, restart script with TWO digits separated by space as script parameters to multiply them"
    exit 1
else
    mltpr=$(($1*$2))
fi

mltp(){
    if [[ $((mltpr % 2)) -eq 0 ]]; then
        echo -e "$mltpr is an even number. Your result is\033[1;32m 0\033[0m"
    else
        echo -e "$mltpr is an odd number. Your result is\033[1;31m 1\033[0m"
    fi
}
mltp
