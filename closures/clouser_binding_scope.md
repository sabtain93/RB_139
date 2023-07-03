# clouser binding & scope

## what is a closure? How it is implemented in Ruby?

closure is a general programming concept, it lets programmers save a piece of code and execute it later in time. It is called a closure as it binds the the names of variables and methods in its surronding and create an enclosure around everything so that they can be referenced when the closure is later executed.

In ruby, a closure is implemnted through a proc object, lambda, or a block. We can pass them around as chunk of code and execute them later. The chunk of code retains the references to its surrounding artifacts which are the closure's **bindings**.

We can now say that closures are formed by blocks, lambda or proc objects. They retain memory of their surrounding scope and can also use and update the variables in that scope when they are executed even when the block, Proc or lambda are called from somewhere esle.

```ruby
def incrementer(arr, num)
  arr.each {|ele| yield(ele + num) }
end

arr = [0, 1, 2, 3, 4]
increment = 1
result = []
counter(arr, increment) do |number|
  result << number
end

p result # [1, 2, 3, 4, 5]

```
In the above example the block passed to `#counter` is invoked from inside the `#counter`, the block still has access to the `results` array through closure.


closure is a chunk of code which can be passed around and can be executed later. closures retain references to its surounding artifacts (names of variables and methods) which are called its bindings. 

In ruby closures are implemented through Proc objects, lambda, or a block (passing a block to a method)


## binding

A closure retains access to variables, constants, and methods that were in scope at the time and location the closure is created. It binds some code with the in-scope items.