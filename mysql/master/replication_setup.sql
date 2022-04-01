SET
    @@GLOBAL.group_replication_bootstrap_group = ON;

CREATE USER IF NOT EXISTS 'replicator' @'%' IDENTIFIED BY 'orc123';

CREATE USER IF NOT EXISTS 'orchestrator' @'%' IDENTIFIED BY 'orc123';

GRANT REPLICATION SLAVE,
USAGE ON *.* TO 'replicator' @'%';

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

GRANT
SELECT
    ON performance_schema.replication_group_members TO 'orchestrator' @'%';

FLUSH PRIVILEGES;

CHANGE MASTER TO MASTER_USER = 'replicator',
MASTER_PASSWORD = 'orc123' for channel 'group_replication_recovery';

START GROUP_REPLICATION;

SET
    @@GLOBAL.group_replication_bootstrap_group = OFF;