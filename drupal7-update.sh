#!/bin/bash

# Set variables
users=(alvarogd artrosis)
drupalversion=7.92
drupal7file=https://ftp.drupal.org/files/projects/drupal-$drupalversion.tar.gz

for user in ${users[@]}; do

    public_html=/home/$user/public_html

    echo ""
    echo "#"
    echo "#"
    echo "# Start $user update"
    echo "#"
    echo "#"

    printf '\n'
    echo "> ($user) Create d-backup directory in user's public_html"
    mkdir $public_html/d-backup

    printf '\n'
    echo "> ($user) Move all core file to d-backup temp folder"        cd $public_html && mv CHANGELOG.txt COPYRIGHT.txt cron.php includes index.php INSTALL.mysql.txt INSTALL.pgsql.txt install.php INSTALL.txt LICENSE.txt MAINTAINERS.txt misc modules profiles scripts themes update.php UPGRADE.txt xmlrpc.php d-backup

    printf '\n'
    echo "> ($user) Download and untar drupal file"
    curl -O $drupal7file -o $public_html && tar -xzpf $public_html/drupal-$drupalversion.tar.gz

    printf '\n'
    echo "> ($user) Move all new version files to public_html"
    cd $public_html/drupal-$drupalversion && mv authorize.php CHANGELOG.txt COPYRIGHT.txt cron.php includes index.php INSTALL.mysql.txt INSTALL.pgsql.txt install.php INSTALL.sqlite.txt INSTALL.txt LICENSE.txt MAINTAINERS.txt misc modules profiles scripts themes update.php UPGRADE.txt web.config xmlrpc.php $public_html

    printf '\n'
    echo "> ($user) Remove all created temp files and folders"
    cd $public_html && rm -rf d-backup drupal-$drupalversion*

    echo ""
    echo "> Restore '$user' permissions"
    chown -R $user: $public_html/*

done

echo ""