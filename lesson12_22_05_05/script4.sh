#! /bin/bash

slct(){
    echo "Choose script to execute (1-3):"
    read -r option
    case $option in
    "1")
        echo "Insert two digits to multiply:"
        read -ra digits
        bash "$PWD"/script1.sh "${digits[@]}"
    ;;
    "2")
        bash "$PWD"/script2.sh
    ;;
    "3")
        bash "$PWD"/script3.sh
    ;;
    esac
}
slct
