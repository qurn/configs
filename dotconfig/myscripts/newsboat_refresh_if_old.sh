#!/bin/bash

let timelimit=10 #in minutes
let timelimit=60*$timelimit #convert in seconds

dir="${XDG_CACHE_HOME:-$HOME/.newsboat}"
last_run_file="$dir/last_time_run"


curent_time=$(date +"%s")
last_time=$(cat "$last_run_file")

diff=$(($curent_time-$last_time))


if [ "$diff" -lt "$timelimit" ]
then 
    newsboat
else
    echo "$curent_time" > "$last_run_file"
    newsboat -r
fi
