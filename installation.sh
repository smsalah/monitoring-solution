Note: Enable the ports (80,443,3306)
sudo yum install -y wget nano git gcc mysql 
git clone https://github.com/smsalah/monitoring-solution.git
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7*.rpm
sudo yum -y install ansible 
sudo tee /etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7 
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg 
EOF
sudo yum -y install https://packages.icinga.org/epel/7/release/noarch/icinga-rpm-release-7-1.el7.centos.noarch.rpm
cp monitoring-solution/project.pem .
chmod 400 project.pem
cd monitoring-solution/Ansible
ansible-playbook -v my.yml
pip install --upgrade pip
sudo docker exec -i -t mydb /bin/bash
mysql -p
GRANT ALL ON *.* to root@'%' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
quit
sudo docker ps
sudo docker inspect <container id>
mysql -P 3306 -u root -p -h 172.17.0.2
docker exec -i -t mydb /bin/bash
cd /etc/mysql
mysql -proot -uroot < icinga.sql
mysql -Dicinga -proot -uroot < icinga_schema.sql
exit
cd /tmp/
tar xzvf monitoring-plugins-2.1.2.tar.gz ; cd monitoring-plugins-2.1.2/
./configure --prefix=/tmp/ && make && make install 
cd /tmp/libexec
find . -print |sudo cpio -dumpv /usr/lib64/nagios/plugins
sudo icinga -d /etc/icinga/icinga.cfg
sudo icinga --show-scheduling /etc/icinga/icinga.cfg
