#!/bin/bash

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
