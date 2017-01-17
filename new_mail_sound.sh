#!/bin/sh

boxes=("/home/wolf/.mutt/maildir/riseup" "/home/wolf/.mutt/maildir/riseup2")
new_mail=false
first_check=true

while true; do
    for i in {0..1}; do
        if $first_check; then
            new=`find ${boxes[i]}/inbox/new/ -type f -print | wc -l`
        else
            new=`find ${boxes[i]}/inbox/new/ -type f -cmin -0.1 -print | wc -l`
        fi
        if [ $new -gt 0 ];then
            new_mail=true
        fi
    done
    if $new_mail; then
        aplay -q /home/wolf/.mutt/beep.wav 
    fi
    new_mail=false
    first_check=false
    sleep 1
done
