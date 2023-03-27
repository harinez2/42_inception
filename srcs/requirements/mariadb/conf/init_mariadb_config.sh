#!/bin/bash

# start sql
service mysql start

# mysql root password
MYSQL_ROOT_PASSWD=maria42
MYSQL_USER_NAME=user42
MYSQL_USER_PASSWD=user42
MYSQL_DB_NAME=db42

# execute mysql_secure_installation script
expect -c '
    set timeout 1;
    spawn sudo mysql_secure_installation;
    expect "Enter current password for root (enter for none): ";
    send -- "\n";
    expect "Set root password?";
    send -- "'Y'\n";
    expect "New password:";
    send -- "'"${MYSQL_ROOT_PASSWD}"'\n";
    expect "Re-enter new password:";
    send -- "'"${MYSQL_ROOT_PASSWD}"'\n";
    expect "Remove anonymous users?";
    send "Y\n";
    expect "Disallow root login remotely?";
    send "Y\n";
    expect "Remove test database and access to it?";
    send "Y\n";
    expect "Reload privilege tables now?";
    send "Y\n";
    interact;'

# create user and db, then add priviledges
expect -c '
    set timeout 1;
    spawn mysql -u root -p;
    expect "Enter password:";
    send -- "'"${MYSQL_ROOT_PASSWD}"'\n";
    expect "MariaDB \[\(none\)\]>";
    send -- "CREATE USER '\'"${MYSQL_USER_NAME}"''\''@'\''localhost'\'' IDENTIFIED BY '\'"${MYSQL_USER_PASSWD}"''\'';\n"
    expect "MariaDB \[\(none\)\]>";
    send -- "CREATE DATABASE `'"${MYSQL_DB_NAME}"'`;\n"
    expect "MariaDB \[\(none\)\]>";
    send -- "GRANT ALL PRIVILEGES ON `'"${MYSQL_DB_NAME}"'`.* TO \"'"${MYSQL_USER_NAME}"'\"@\"localhost\";\n"
    expect "MariaDB \[\(none\)\]>";
    send -- "FLUSH PRIVILEGES;\n"
    expect "MariaDB \[\(none\)\]>";
    send -- "exit;\n"
    interact;'

# stop sql
service mysql stop
