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

# stop sql
service mysql stop
