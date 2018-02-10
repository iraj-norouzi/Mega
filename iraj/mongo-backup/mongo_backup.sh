#!/bin/bash
# Bash script to backup MongoDB +3 database
# Version 1.0
############################
############################
# [General]
DUMP_PATH="/var"
LOG_FILE="/var/log/IBSng/ibs_mongo_backup.log"

# [MongoDB]
M_HOST="localhost"
M_PORT="27017"
M_DATABASE="IBSng"
M_COLLECTION="connection_log"
############################
############################

FILE_NAME=$(date  '+%Y-%m-%d-%H-%M-%S')
echo "[!] $(date  '+%Y-%m-%d-%H:%M:%S') - Starting MongoDB backup" | tee -a $LOG_FILE

DATE=`mongo IBSng --eval "ISODate('$(date  '+%Y-%m-01')').getTime()" | tail -n 1`
QUERY="{'logout_time': {'\$gte': Date($DATE)}}"
echo $QUERY > /tmp/jsonquery

echo "[!] $(date  '+%Y-%m-%d-%H:%M:%S') - Running with query $QUERY" | tee -a $LOG_FILE
time mongodump --host $M_HOST:$M_PORT \
               --collection=$M_COLLECTION \
               --db $M_DATABASE \
               --gzip \
               --archive=${DUMP_PATH}/${FILE_NAME}.dump \
               --queryFile=/tmp/jsonquery | tee -a $LOG_FILE

echo "[!] $(date  '+%Y-%m-%d-%H:%M:%S') - Backup finished" | tee -a $LOG_FILE

