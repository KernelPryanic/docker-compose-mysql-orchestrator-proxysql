docker-compose deployment of ProxySQL, MySQL and Replication Manager stack.

## Setup
To switch between GTID and Positional replication types you can use `switch_deployment_type.sh` script. Ex.:
```
./switch_deployment_type.sh gtid
```
GTID replication mode uses `autorejoin-gtid.sh` custom rejoin script for Replication Manager.
Positional replication uses pseudo GTID.

## Deployment
```
docker-compose up -d
```
Replication Manager web UI will be available at: `localhost:3000`
Default credentials: `admin:repman`

## Destruction
```
docker-compose down -v
```
