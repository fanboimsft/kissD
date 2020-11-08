export CFLAGS="-march=native -O3 -pipe"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$(($(nproc)+2))"

alias ls="ls --color" 
