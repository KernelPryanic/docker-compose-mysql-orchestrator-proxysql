CREATE USER IF NOT EXISTS 'orchestrator' @'%' IDENTIFIED BY 'pass123';

CREATE DATABASE IF NOT EXISTS orchestrator;

GRANT ALL ON orchestrator.* TO 'orchestrator' @'%';

FLUSH PRIVILEGES;