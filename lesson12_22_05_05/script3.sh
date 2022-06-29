#! /bin/bash

arrfn(){
    echo "Just enter some 4-5 symbols separated by space. Any:"
    read -ra arr
    for i in "${arr[@]}"; do
        echo -e "$i"
    done
}
arrfn
