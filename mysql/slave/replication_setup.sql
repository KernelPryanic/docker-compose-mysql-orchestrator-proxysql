stop slave;

CHANGE MASTER TO MASTER_HOST = 'mysql_master',
MASTER_USER = 'replicator',
MASTER_PASSWORD = 'pass123',
MASTER_AUTO_POSITION = 1;

start slave;

RESET MASTER;