#!/bin/bash
# set this script up with cron to run every 1 minute
# set the target to your ToDo notepad:
var=$(cat /var/www/html/_tmp/phone)
# Make a line in your ToDo notepad with #### TODO
# Beneath that line put each item with 24 hour time and then the task todo
# ie: 0530 get up for work
# set name of your ntfy.sh server and make sure it is accessible:
ntfysrv="http://192.168.103.7/alert"
#
#
dtm=$(echo $(date '+%H%M'))
echo $dtm
vr2=$(echo "${var#*TODO}")
vr3="${vr2//$'\n'/,}"
nvr="${vr3// /_}"
echo "$nvr"
for i in $(echo $nvr | sed "s/,/ /g")
do
        if [[ $i == $dtm* ]];
        then
                cvr=$(echo "${i//_/ }")
                cv2=$(echo ${cvr:5})
                curl -d "${cv2}" $ntfysrv
        fi
done
