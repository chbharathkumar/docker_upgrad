sudo rm -rf /var/lib/docker
sudo mkdir /var/lib/docker
sudo lvremove /dev/docker/thinpool 
sudo lvcreate -n dockerdata -l 100%FREE docker -y
sudo mkfs -t xfs -n ftype=1 /dev/docker/dockerdata
sudo mount /dev/docker/dockerdata /var/lib/docker
