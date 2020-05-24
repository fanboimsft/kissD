#!/bin/sh

#check if run as root
#[ $UID -eq 0 ] && echo "Don't run this script as root!" && exit 1

#help output
if [ "$1" == "-h" ]
then
	echo "Script to build the LFS systemd toolchain."
	echo "Usage:"
	echo -e "\t$0 [package]"
	echo -e "\tpackage: First package in list to get installed. This is to be able to continue where you left of before."
	exit 0
fi

[ -z $LFS ] && echo "LFS environment variable isn't set." && exit 1
[ -z $LFS_TGT ] && echo "LFS_TGT environment variable isn't set." && exit 1

[ "$(readlink -f /tools)" != "$(readlink -f "${LFS}/tools")" ] && echo "'/tools' has to be a symlink to '${LFS}/tools'" && exit 1
[ -z $1 ] && [ ! -z "$(ls /tools)" ] && echo "'/tools' has to be empty!" && exit 1

#load settings from ~/.lfs-me
[ -f ~/.lfs-me ] && source ~/.lfs-me

#check settings from ~/.lfs-me
[ "$(readlink -f "$log_dir")" != "$(readlink -f "${LFS}/tools/var/log/lfs-me")" ] && echo "log_dir is set to the wrong directory '$log_dir', it should be '${LFS}/tools/var/log/lfs-me'" && exit 1
[ "$(readlink -f "$index_dir")" != "$(readlink -f "${LFS}/tools/var/lfs-me/index")" ] && echo "index_dir is set to the wrong directory '$index_dir', it should be '${LFS}/tools/var/lfs-me/index'" && exit 1

#set settings
log_dir="${LFS}/tools/var/log/lfs-me"
index_dir="${LFS}/tools/var/lfs-me/index"

export LFS LFS_TGT log_dir index_dir

install=(
	'binutils-pass1'
	'gcc-pass1'
	'linux-headers'
	'glibc'
	'libstdc++'
	'binutils-pass2'
	'gcc-pass2'
	'tcl'
	'expect'
	'dejagnu'
	'm4'
        'ncurses'
	'bash'
	'bison'
        'flex'
	'bzip2'
	'coreutils'
	'diffutils'
	'file'
	'findutils'
	'gawk'
	'gettext'
	'grep'
	'gzip'
	'make'
	'patch'
	'perl'
	'Python3'
	'sed'
	'texinfo'
	'util-linux'
	'xz'
	'nano'
	'tar'
	'zlib'
	'libressl'
	'curl'
        'kiss'
)

mkdir -v pkg

[ -f build-toolchain.log ] && rm build-toolchain.log
touch build-toolchain.log

for package in "${install[@]}"
do
	if [ -z $1 ] || [ $1 == $package ]
	then
		shift "$#" #remove commandline parameters
		echo "BUILDING ${package}"
		lfs-me build "$package" --no-cert-check | tee -a build-toolchain.log
		[ ! ${PIPESTATUS[0]} -eq 0 ] && echo "Building '$package' failed!" && exit 1
		mv ${package}*.pkg  pkg/
		rm /tools/share/info/dir
		lfs-me install pkg/${package}*.pkg | tee -a build-toolchain.log
		[ ! ${PIPESTATUS[0]} -eq 0 ] && echo "Installing '$package' failed!" && exit 1
	fi
done
