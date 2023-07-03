## Methods with an explicit block parameter

blocks can be passed to methods explicitly.

An explicit block is a block that gets treated as a named object, it gets assinged to a method parameter so it can be reassigned, passed to other methods, and invoked many times.

To define an explicit block just add a parameter to the method definition where the name begins prepended with a `&` character.

```ruby
def my_method(&block)
  puts "The &block is #{block}"
end

# The &block is #<Proc:0x05274258
```
The `&block` is a special parameter that converts the block into a simple Proc object. The `&` is dropped when we reference the parameter inside the `my_method` method.

Here we can see the `block` method local variable is a `Proc` object.

An explicit block gives additional flexiablity as now we have handle to the block, it can now be passed to other methods. Before we can only yield the implict block.

```ruby
def other_method(block)
  block.call
end

def my_method(&block)
  puts "start"
  other_method(block)
  puts "end"
end

my_method { puts "this is a block"}

# start
# this is a block
# end
```

In the above example we only need to use `block` parameter in `#my_method`. As `block` is already a Proc object we can pass it to the method `#other_method`.

We use `block.call` inside `#other_method` to invoke the Proc object, not yeild.

We can pass arguments to explicit block by passing them as argument to `call`.

```ruby
def other_method(block)
  block.call("==>>")
end

def my_method(&block)
  puts "start"
  other_method(block)
  puts "end"
end

my_method { |prefix| puts "#{prefix} this is a block"}

# start
# ==>> this is a block
# end
```