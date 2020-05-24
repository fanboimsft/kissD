cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
export CFLAGS="-march=x86-6"
export CXXFLAGS="${CFLAGS}"
export MAKEOPTS="-j6"
export MAKEFLAGS="-j6"
alias ls='ls --color'
alias lfs='lfs-me'
EOF

source ~/.bash_profile


