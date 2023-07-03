# Blocks and variable scope

Blocks, procs and lambda is how closures are implemented in Ruby. They are unnamed chunk of code which can be passed around in our code base and can be executed later. In order for them to be executed later they need to retain the information of its surrounding from where it is defined.

example

```ruby
school = 'Har'
chunk_of_code = Proc.new { puts "I go to #{school}"}

```
In the above example we have created a new proc object but we are not executing it.

```ruby
def call_proc(proc_obj)
  proc_obj.call
end

school = 'Harvard'

chunk_of_code = Proc.new { puts "I go to #{school}"}

call_proc(chun_of_code)

# I go to Harvard
# => nil

```

```ruby
def call_proc(proc_obj)
  proc_obj.call
end

school = 'Harvard'

chunk_of_code = Proc.new { puts "I go to #{school}"}

school = 'Stanford'

call_proc(chun_of_code)

# I go to stanford
# => nil

```

In the above two examples we can see that the proc object referenced by chunk_of_code has access to the local variable `school` and when the school local variable is reassigned this is also reflected. This implies that `Proc` keep tracks of its surrounding context and drags it around where ever the chunk of code is passed to. Here the `chunk_of_code` is passed to the `#call_proc` its bindings are dragged along with it and this is how the `Proc` is aware of the `school` local variable reassignment.

A closure must keep track of its bindings to have all the information it need to be executed later, this not only includes local variables but also methods, constants and other artifacts.

note:
Any local variable the closure needs to access must be defined before the closure is created, unless the local variable is explicitly passed when the closure is called.

In the above example if the `school` local variable is removed from `line 35` this changes the binding of the `Proc` and the `school` local variable is no longer in scope.