#!/bin/bash

# start sql
service mysql start

# execute mysql_secure_installation script
expect -c '
    set timeout 1;
    spawn sudo mysql_secure_installation;
    expect "Enter current password for root (enter for none): ";
    send -- "\n";
    expect "Set root password?";
    send -- "'n'\n";
    expect "Remove anonymous users?";
    send "Y\n";
    expect "Disallow root login remotely?";
    send "N\n";
    expect "Remove test database and access to it?";
    send "Y\n";
    expect "Reload privilege tables now?";
    send "Y\n";
    interact;'
echo "mysql_secure_installation finished:$?"

# add user, grant all to the user, add root password
	tmp_file=tmp_file
	cat << EOL > $tmp_file
CREATE USER IF NOT EXISTS '$MYSQL_USER_NAME'@'%' IDENTIFIED by '$MYSQL_USER_PASSWD';
GRANT ALL ON *.* TO '$MYSQL_USER_NAME'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWD';
FLUSH PRIVILEGES;
EOL
	mysql --user=root < $tmp_file
	rm -f $tmp_file
echo "initial sql execution finished:$?"

# stop sql
kill $(cat /var/run/mysqld/mysqld.pid)
#service mysql stop
