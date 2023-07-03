# methods and blocks can return chunks of code (closures)

methods and blocks can return closure. method cannot return blocks but they can return `Proc`s.


example:

```ruby
def counter
  count = 0
  Proc.new { count + 1 }
end

a1 = counter
p a1.call
p a1.call
p a1.call

a2 = counter

p a2.call
p a1.call
p a2.call
p a2.call
```
In the above example the `#counter` method returns a Proc which forms a closure with local variable `count`. now we can call the Proc object repeatedly. Everytime the proc object is called it updates a private copy of the `count` local vairable. We can create multiple Proc object by calling the `#counter` method and each Proc object will have its own private copy of the `count` local variable. This is why when we call the `#counter` and assign the return value to  `a2`, the `count` associated with `a2` is independent and seprate from `a1`.

So we can say that methods and blocks can return Procs and lambdas and that can then be called.