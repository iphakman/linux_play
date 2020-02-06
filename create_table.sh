#!/bin/bash

##################################################################
## This script will help us to create a table in html code, then
## we could add to any file.
##
## Version: 0.1
## Autor: Phakman
## Date: 2/6/2020
##################################################################

columns=$1
filename=$2

if [[ $# -eq 3 ]]
then
  delim=$3
else
  delim=','
fi

result_file=/tmp/my_table.htm
>$result_file

printf "table" >>$result_file
# print the headers

printf "tr" >>$result_file
for g in $columns
do
  printf "<th>$g</th>" >>$result_file
done
printf "/tr" >>$result_file

cat $filename | awk -F"${delim}" 'BEGIN{OFS=""}{print "<tr>"; for(i=1;i<=NF;i++){print "<td>",$i,"</td>"}; print "</tr>"}' >>$result_file

# print the tail
printf "</table>" >>$result_file

ls -l $result_file
cat $result_file
