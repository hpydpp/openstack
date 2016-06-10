cp /etc/yum.repos.d/yum.repo /etc/yum.repos.d/mariadb.repo
sed -i 's/0local/1local/g' /etc/yum.repos.d/mariadb.repo
sed -i 's/Packages/Mariadb/g' /etc/yum.repos.d/mariadb.repo
yum install mariadb-server -y
mkdir /var/run/mariadb
chown mysql.root /var/run/mariadb
service mysql start

echo -e "mkdir /var/run/mariadb\nchown mysql.root /var/run/mariadb\nservice mysql start" >> /etc/rc.local
chmod +x /etc/rc.d/rc.local

rm /root/mariadb.sh -f
