## Arity of blocks and methods

The number of arguments that you must pass to a block or lamba or a proc in Ruby is called its arity.
Blocks and Procs have lenient arity this is why Ruby does not raise error when too many or too less arguments are passed to a block.

Methods and lambdas have a very strict arity, which means that the number of arguments passed to a method must be the exact number of arguments that it expects.

So we can say that methods enforce argument count and blocks do not.