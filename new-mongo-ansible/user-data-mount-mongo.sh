#! /bin/bash
#sudo amazon-linux-extras install -y epel

#sudo fdisk -l | grep /dev/nvme1n1  | cut -d " " -f2 |  cut -d ":" -f1
#sudo export DEVICE=`fdisk -l | grep /dev/nvme1n1  | cut -d " " -f2 |  cut -d ":" -f1`
#sudo mkfs.ext4 $DEVICE
#sudo mount $DEVICE /data/
#sudo echo "$DEVICE /data ext4 discard,errors=remount-ro	0 0" >> /etc/fstab
#sudo mount -a  $DEVICE /data/
#
#DEVNAME=lsblk | awk 'END {print}'| awk '{print $1}'
#DEVICE=`fdisk -l | grep /dev/$DEVNAME  | cut -d " " -f2 |  cut -d ":" -f1`

export DEVNAME=$(lsblk | awk 'END {print}'| awk '{print $1}')
export DEVICE=`fdisk -l | grep /dev/$DEVNAME  | cut -d " " -f2 |  cut -d ":" -f1`
sudo mkfs.ext4 $DEVICE
sudo mount $DEVICE /data/
sudo echo "$DEVICE /data ext4 discard,errors=remount-ro 0 0" >> /etc/fstab
sudo mount -a  $DEVICE /data/
