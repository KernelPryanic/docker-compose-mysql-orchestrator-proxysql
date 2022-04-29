#!/bin/bash

help() {
	echo -e "Usage: $0 <parameters> <type>
Types:
 - gtid
 - positional
Parameters:
 -h - Show this message
"
}

if [ -z "$1" ] || [ "$1" = "-h" ]; then
	help
	exit 0
fi

case "$1" in
gtid)
	sed -E 's/(^autorejoin-backup-binlog|force-slave-no-gtid-mode|autorejoin-slave-positional-hearbeat)(\s*=\s*[^ ]+)(.*)/\1 = false\3/' -i replication-manager/config.toml
	shift
	;;
positional)
	sed -E 's/(^autorejoin-backup-binlog|force-slave-no-gtid-mode|autorejoin-slave-positional-hearbeat)(\s*=\s*[^ ]+)(.*)/\1 = true\3/' -i replication-manager/config.toml
	shift
	;;
*)
	help
	exit 1
	;;
esac
