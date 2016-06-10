sed -i "s/http:\/\/docs.openstack.org//g" /etc/openstack-dashboard/local_setting /usr/share/openstack-dashboard/openstack_dashboard/settings.py
sed -i "s/LANGUAGES_CODE='en'/LANGUAGE_CODE='zh-cn'/g" 	/usr/share/openstack-dashboard/openstack_dashboard/settings.py
sed -i "s/OpenStack Dashboard/模拟仿真平台/g" /usr/share/openstack-dashboard/openstack_dashboard/settings.py
sed -i "1i # -*- coding: utf-8 -*-" /usr/share/openstack-dashboard/openstack_dashboard/settings.py
sed -i "s/'can_set_password': False/'can_set_password': True/g" /usr/share/openstack-dashboard/openstack_dashboard/local/local_settings.py
systemctl httpd restart
rm /root/dashboard.sh -f
