sed -i "s/inject_password=False/inject_password=True/g" /etc/nova/nova.conf
sed -i "s/inject_key=False/inject_key=True/g" /etc/nova/nova.conf
sed -i "s/inject_partition=-2/inject_partition=-1/g" /etc/nova/nova.conf
systemctl restart openstack-nova-compute
rm /root/inject_passwd.sh -f
