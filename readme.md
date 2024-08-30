# luma

a minimal lisp/lua-like language

see [intro.luma](intro.luma) (or [with highlighting](https://snowkitty.online/luma/intro.html))
for an introduction to the language

## usage

to compile the compiler:

- run `./build-compiler.sh` from the `src/` directory
- the built compiler is output to `build/compile-luma-built.lua`,
  and any diffs from `build/compile-luma.lua` are shown

to use in a project:

- copy `src/prelude.luma` and `src/build/luma-compile.lua` to a new directory
- compile your code with `luajit luma-compile.lua <your-source>.luma <your-output>.lua`
- run your compiled code with `luajit <your-output>.lua`

you can use regular lua instead of luajit, the output will differ slightly due
to different string quotation behaviour

in case of an error, the raw lua backtrace is shown along
with luma source locations to the right, where available

## status

luma is still very experimental and might change a lot

some things i'd like to add:

- more tests in this repo
- more examples
- more and better error checking
- clearer class/object differentiation
