#!/bin/bash

# if grep myfolder ~/
# then echo "'myfolder' exists"
# else mkdir ~/myfolder

if [ -d "~/myfolder" ] 
then
    echo "Directory ~/myfolder exists." 
else
    mkdir ~/myfolder && echo "Directory ~/myfolder does not exist. Created" 
fi

echo -e "Hello, stranger.\n$(date)" > ~/myfolder/file1
touch ~/myfolder/file2 && sudo chmod 777 ~/myfolder/file2
rnd20=$(openssl rand -hex 20) && echo $rnd20 > ~/myfolder/file3
touch ~/myfolder/file4
touch ~/myfolder/file5