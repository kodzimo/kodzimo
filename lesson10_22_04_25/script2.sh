#!/bin/bash

# amount=$(grep -c * ~/myfolder)
# echo $amount
ls ~/myfolder | wc -l
sudo chmod 644 ~/myfolder/file2
find ~/myfolder -type f -empty -delete
sed -i '1!d' ~/myfolder/file1
sed -i '1!d' ~/myfolder/file3