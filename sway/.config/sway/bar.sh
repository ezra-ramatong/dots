#!/usr/bin/env bash

while true
do
    msg='This will display on the bar'
    date=$(date +'%a %F')
    time=$(date +'%H:%M')
    echo "$date | $time"
    sleep 1
done 

