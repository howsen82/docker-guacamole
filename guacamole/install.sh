curl -LsS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash -s --
sudo apt update
sudo apt install mariadb-server mariadb-client
sudo systemctl enable --now mariadb

$ sudo vim /etc/mysql/mariadb.conf.d/50-server.cnf
[mysqld]
bind-address            = 0.0.0.0

sudo systemctl restart mariadb
sudo mysql -u root

CREATE DATABASE guacamole_db;
CREATE USER 'guacamole_user'@'%' IDENTIFIED BY 'StrongPassw0rd';
GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole_db.* TO 'guacamole_user'@'%';
FLUSH PRIVILEGES;
QUIT;

docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgres > initdb.sql
cat initdb.sql | sudo mysql -u root -p guacamole_db

sudo ufw allow 3306/tcp

$ vim .env
MYSQL_USER=guacamole_user
MYSQL_PASSWORD=StrongPassw0rd
MYSQL_DATABASE=guacamole_db
MYSQL_HOSTNAME=192.168.207.95
GUACD_HOSTNAME=192.168.207.95

# Start Guacamole Docker Services
$ docker compose up -d
$ docker ps --format table
sudo ufw allow 8080/tcp