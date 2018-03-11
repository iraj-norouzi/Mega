#!/bin/bash

config_dir=/usr/local/src/tools/db/ibsng_backup/hourly
backup_dir=/var/backups/IBSng/postgres-cluster/hourly
pre_end=$(cat $backup_dir/pre_end) &> /dev/null

# get config file
source $config_dir/config_file

# get epoch lsat backup date
last_backup=$(ls -ls $backup_dir/$pre_end/* | head -n 2 | tail -n 1 | awk '{print $7,$8,$9}')
last_epoch=$(date "+%s" -d "$last_backup")

if [[ ! -s $backup_dir/$pre_end ]]; then
        echo 0
        exit 1
fi

# set interval by type variable in config file
if [[ $type = "daily" ]]; then
        interval_time=$((24 * 3600))
elif [[ $type = "weekly" ]]; then
        interval_time=$((24 * 7 * 3600 ))
elif [[ $type == "monthly" ]]; then
        interval_time=$((30 * 24 * 3600))
else
        interval_time=$(($interval * 1 * 3600 ))
fi

# set interval for a true backup, you can change this value, 1h = 60min * 60sec = 3600s
interval_epoch_1=$(($interval_time+300)) # +5 min

# get last poch date
date_epoch=$(date "+%s")
date_diff=$(($date_epoch-$last_epoch))

if [[ $date_diff -lt $interval_epoch_1 ]]; then
        echo 1
else
        echo 0
fi
