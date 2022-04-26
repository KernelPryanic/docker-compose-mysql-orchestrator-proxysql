#!/bin/bash

# Slave monitoring function
is_slave_ready() {
slave_status=$(mysql -uroot -ppass123 -h$1 <<-EOF
SHOW SLAVE STATUS\G;
EOF
)

    master_log_file=$(echo $slave_status | grep -oP "\sMaster_Log_File: ([^\s:]+\s)" | awk '{print $2}')
    exec_master_log_pos=$(echo $slave_status | grep -oP "\sExec_Master_Log_Pos: ([^\s:]+\s)" | awk '{print $2}')
    seconds_behind_master=$(echo $slave_status | grep -oP "\sSeconds_Behind_Master: ([^\s:]+\s)" | awk '{print $2}')
    master_uuid=$(echo $slave_status | grep -oP "\sMaster_UUID: ([^\s:]+\s)" | awk '{print $2}')
    if [[ $master_log_file == "" || $exec_master_log_pos == "0" || $seconds_behind_master == "NULL" || $master_uuid == "" ]]; then
        return 0
    else
        return 1
    fi
}

# Rejoin the old master to the cluster
setup_master_status=$(mysql -uroot -ppass123 -h$1 <<-EOF
CHANGE MASTER TO MASTER_HOST = "$2",
MASTER_USER = 'replicator',
MASTER_PASSWORD = 'pass123',
MASTER_AUTO_POSITION = 1;
EOF
)

# old_master_id=$(replication-manager-cli topology --cluster main | awk -v target_host=$1 '$2 == target_host && $4 = "Slave" {print $1}')

# Skip corrupted replication event
cluster_name=$(replication-manager-cli show | jq -r --arg target_host $1 '.clusters[] | select(.servers[].name == $target_host) | .Name')
old_master_id=$(replication-manager-cli show | jq -r --arg target_host $1 '.clusters[].servers[] | select(.name == $target_host) | .id')
replication-manager-cli api --url="http://127.0.0.1:10001/api/clusters/${cluster_name}/servers/${old_master_id}/actions/skip-replication-event" --cluster="${cluster_name}"

if [[ $? == 0 ]]; then
    echo "################ $1 succeed to join new master $2 ################"
else
    echo "################ $1 failed to join new master $2 ################"
fi

#### Deprecated ####

# # Initiate failed transaction skip
# transactions_log_restore=$(mysql -uroot -ppass123 -h$1 <<-EOF
# stop slave;
# set global gtid_mode=ON_PERMISSIVE;
# SET GLOBAL SQL_SLAVE_SKIP_COUNTER = 1;
# start slave;
# EOF
# )

# # Monitor the slave status for $monitor_time seconds
# monitor_time=60
# i=0
# slave_is_ready=$(is_slave_ready $1)
# while [[ $slave_is_ready == 0 && $i < $monitor_time ]]; do
#     sleep 1
#     slave_is_ready=$(is_slave_ready $1)
#     ((i=i+1))
# done

# if [[ $i == $monitor_time ]]; then
#     echo "$1 failed to join new master $2"
# else
# setup_master_status=$(mysql -uroot -ppass123 -h$1 <<-EOF
# set global gtid_mode=ON;
# EOF
# )
#     echo "$1 succeed to join new master $2"
# fi
