export CFLAGS="-march=native -O3 -pipe"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$(($(nproc)+2))"
export KISS_HOOK=/etc/kiss-hook
export KISS_SU=su

alias ls="ls --color" 
