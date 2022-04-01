-- stop slave;
-- CHANGE MASTER TO MASTER_HOST = 'mysql_master',
-- MASTER_USER = 'replicator',
-- MASTER_PASSWORD = 'orc123',
-- MASTER_AUTO_POSITION = 1;
-- start slave;
-- SET
-- GLOBAL read_only = 1;
SET
    SQL_LOG_BIN = 0;

CHANGE MASTER TO MASTER_USER = 'replicator',
MASTER_PASSWORD = 'orc123' for channel 'group_replication_recovery';

RESET MASTER;

SET
    SQL_LOG_BIN = 1;

START GROUP_REPLICATION;