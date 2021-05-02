#!/bin/bash

# Script is going commando, no checks, no nothing,  and it depends on 
# `check_if_email_exists` being in path
#
# Outputs `bounced.csv` in current working directory

cat $1 | while read line 

do
    email=`echo ${line} | sed 's/\\r//g'`
    ./check_if_email_exists ${email} > /tmp/out.json
    status="$(sed '/is_deliverable/!d' /tmp/out.json)"
    if [[ "${status}" == *"false"* ]]; then
        echo "${email}, bounced" >> bounced.csv
    fi
    rm /tmp/out.json
done
