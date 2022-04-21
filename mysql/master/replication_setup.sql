CREATE USER IF NOT EXISTS 'replicator' @'%' IDENTIFIED BY 'pass123';

GRANT REPLICATION SLAVE,
USAGE ON *.* TO 'replicator' @'%';

CREATE USER IF NOT EXISTS 'orchestrator' @'%' IDENTIFIED BY 'pass123';

GRANT RELOAD,
PROCESS,
SUPER,
REPLICATION SLAVE,
REPLICATION CLIENT,
USAGE ON *.* TO 'orchestrator' @'%';

GRANT DROP ON `_pseudo_gtid_`.* TO 'orchestrator' @'%';

GRANT
SELECT
    ON mysql.slave_master_info TO 'orchestrator' @'%';

GRANT
SELECT
    ON meta.* TO 'orchestrator' @'%';

CREATE USER IF NOT EXISTS 'proxysql' @'%' IDENTIFIED BY 'pass123';

GRANT
SELECT
    on sys.* to 'proxysql' @'%';

FLUSH PRIVILEGES;

-- SET GLOBAL group_replication_bootstrap_group = ON;
-- START GROUP_REPLICATION;
-- SET GLOBAL group_replication_bootstrap_group = OFF;

-- stop slave;

-- CHANGE MASTER TO MASTER_HOST = 'mysql_slave',
-- MASTER_USER = 'replicator',
-- MASTER_PASSWORD = 'pass123',
-- MASTER_AUTO_POSITION = 1;

-- start slave;