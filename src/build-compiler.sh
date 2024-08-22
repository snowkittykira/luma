set -e
echo 'compiling build/luma-compile-built.lua using build/luma-compile.lua ..'
luajit build/luma-compile.lua compiler/command.luma build/luma-compile-built.lua
echo ''
echo 'diff:'
echo ''
if diff build/luma-compile.lua build/luma-compile-built.lua; then
    echo 'no differences'
    echo ''
fi
