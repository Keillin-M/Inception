-- Applied by tools/script.sh on every container start.
-- The ${...} placeholders are substituted by `envsubst` using values
-- from /run/secrets/* (passwords) and the .env file (user, database).

-- Set the root password every boot so it stays in sync with the secret.
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';

-- The application database. IF NOT EXISTS makes this safe to re-run.
CREATE DATABASE IF NOT EXISTS `${MYSQL_DATABASE}`;

-- Drop and recreate the application user. Doing it this way guarantees the
-- user's password matches the current secret on every boot — if the secret
-- is rotated, the user follows.
DROP USER IF EXISTS '${MYSQL_USER}'@'%';
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON `${MYSQL_DATABASE}`.* TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
