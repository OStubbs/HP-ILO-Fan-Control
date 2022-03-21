#!/bin/bash
#
# crontab -l > mycron
# echo "#" >> mycron
# echo "# At every 2nd minute" >> mycron
# echo "*/1 * * * * /bin/bash /autofan.sh >> /tmp/cron.log" >> mycron
# crontab mycron
# rm mycron
# chmod +x /autofan.sh
#
USERNAME="your username"
KEY_PATH="/path/to/key"
ILOIP="your ilo ip"

T1="$(sensors -Aj coretemp-isa-0000 | jq '.[][] | to_entries[] | select(.key | endswith("input")) | .value' | sort -rn | head -n1)"
T2="$(sensors -Aj coretemp-isa-0001 | jq '.[][] | to_entries[] | select(.key | endswith("input")) | .value' | sort -rn | head -n1)"

FAN1=`awk "BEGIN {printf \"%.0f\n\", ((($T1-22)**3)/$T1**1.75)+35}"`
FAN2=`awk "BEGIN {printf \"%.0f\n\", ((($T2-22)**3)/$T2**1.75)+35}"`

echo "==============="
echo "CPU 1 Temp $T1 C"
echo "==============="

ssh -i KEY_PATH $USERNAME@$ILOIP "fan p 3 min $FAN1"
ssh -i KEY_PATH $USERNAME@$ILOIP "fan p 4 min $FAN1"
ssh -i KEY_PATH $USERNAME@$ILOIP "fan p 5 min $FAN1"

echo "==============="
echo "CPU 2 Temp $T2 C"
echo "==============="

ssh -i KEY_PATH $USERNAME@$ILOIP "fan p 0 min $FAN2"
ssh -i KEY_PATH $USERNAME@$ILOIP "fan p 1 min $FAN2"
ssh -i KEY_PATH $USERNAME@$ILOIP "fan p 2 min $FAN2"
