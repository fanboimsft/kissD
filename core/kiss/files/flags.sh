export CFLAGS="-march=x86-64 -mtune=generic -Os -pipe"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$(($(nproc)+2))"
export KISS_HOOK=/etc/kiss-hook
export KISS_SU=su
export XZ_OPT="-T0"

alias ls="ls --color" 
