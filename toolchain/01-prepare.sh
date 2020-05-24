#!/bin/bash
LFS=/mnt/lfs

mkdir -v $LFS/tools
ln -sv $LFS/tools /
groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
chown -v lfs $LFS/tools
cp misc/lfs-me /usr/bin/
chmod +x /usr/bin/lfs-me
cp misc/lfsmerc-toolchain /home/lfs/.lfs-me
chown lfs:lfs /home/lfs/.lfs-me
chown -R lfs:lfs ../.
echo "Now switch to the lfs user, make sure rsync is installed"
