# <center>HW 12 Scripts</center>
## Script 1
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
## Script 2
    #! /bin/bash

    if [[ $# -ne 0 ]]; then
        echo "Please, restart script with 0 parameters. You will be prompted to enter one."
        exit 1
    fi
    prtfls(){
        echo "Enter the path to recursively print file names from:"
        read -r key
        if [[ ! -d $key || ! -s $key ]]; then
            echo "$key is empty or not a directory."
            exit 1
        else 
            ls -Rx "$key"
            # content=$(ls -Rx "$key")
            # echo "$content"
            # for i in $content; do
            #     if [[ ! -d $key/$i ]]; then  # перебор и вывод имени файла пока не встретит директорию 
            #         echo "$i"
            #     else
            #         content1=$(ls "$key$i"/)
            #         echo "$content1"
            #     fi
            # done
        fi
    }
    prtfls
## Script 3
    #! /bin/bash

    arrfn(){
        echo "Just enter some 4-5 symbols separated by space. Any:"
        read -ra arr
        for i in "${arr[@]}"; do
            echo -e "$i"
        done
    }
    arrfn
## Script 4
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


    add super-linter test