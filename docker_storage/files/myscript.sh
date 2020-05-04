sudo pvcreate /dev/sdb
sudo vgcreate docker /dev/sdb
sudo lvcreate --wipesignatures y -n thinpool docker -l 95%VG
sudo lvcreate --wipesignatures y -n thinpoolmeta docker -l 1%VG
sudo lvconvert -y \
--zero n \
-c 512K \
--thinpool docker/thinpool \
--poolmetadata docker/thinpoolmeta
sudo lvchange --metadataprofile docker-thinpool docker/thinpool

sudo rm -rf /var/lib/docker
sudo mkdir /var/lib/docker
sudo lvremove /dev/docker/thinpool -y
sudo lvcreate -n dockerdata -l 100%FREE docker -y
sudo mkfs -t xfs -n ftype=1 /dev/docker/dockerdata
sudo mount /dev/docker/dockerdata /var/lib/docker
