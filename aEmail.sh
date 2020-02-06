#!/bin/bash

##############################################################################
##      To send email with attachments we just need to prepare the body
##      in html format.
##      We need to pass the file(s) to be attached all inside quotes
##      and preferible using the absolute path and separated by spaces.
##      i.e. "/home/miuser/file1.csv /tmp/math.txt"
##              PARAMETERS Required
##                      1) Subject
##                      2) Email body (File)
##                      3) To list
##                      4) Files to be attached in email
##############################################################################
set -x

(
echo "To: $3"
echo "Subject:$1"
echo "Mime-Version: 1.0"
echo 'Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"'
echo "Content-Disposition: inline"
echo ""
echo "--GvXjxJ+pjyke8COw"
echo "Content-Type: text/html; charset=us-ascii"
echo "Content-Transfer-Encoding: 7bit"
echo "Content-Disposition: inline"
cat $2
if [[ $# -gt 3 ]]
then
for ff in $4
do
f1=`echo $4 | awk -F"/" '{print $NF}'`
echo "--GvXjxJ+pjyke8COw"
echo "Content-Type: application/octet-stream; name=$f1"
echo "Content-Disposition: attachment; filename=$f1"
cat ff
echo "--GvXjxJ+pjyke8COw--"
done
fi
) | /usr/sbin/sendmail -oi -f 'sender@email.mx' -t "$3" 
