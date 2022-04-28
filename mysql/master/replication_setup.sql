CREATE USER IF NOT EXISTS 'replicator' @'%' IDENTIFIED BY 'pass123';

GRANT REPLICATION SLAVE,
USAGE ON *.* TO 'replicator' @'%';

CREATE USER IF NOT EXISTS 'proxysql' @'%' IDENTIFIED BY 'pass123';

GRANT
SELECT
    on sys.* to 'proxysql' @'%';

FLUSH PRIVILEGES;
