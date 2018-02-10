# MongoDB Backup

This is a simple script which uses **mongodump** built-in command  to dump mongo data for the current month.

### Configs

**DUMP_PATH**: Absolute path for the dump

**LOG_FILE**: Script's self log path

**M_HOST**: MongoDB Host

**M_PORT**: MonogDB Port

**M_DATABASE**: MongoDB Database (default: IBSng)

**M_COLLECTION**: MongoDB Collection (default: connection_log)



### Changelogs

V1.0:

​	* Backs up MongoDB data for the current month