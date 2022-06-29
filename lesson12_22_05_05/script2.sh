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
