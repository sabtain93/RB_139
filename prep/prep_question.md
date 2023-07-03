# BLOCKS

1, What are closures?

- closures are chunks of code that can be passed around be executed later. The chunk of code retains the references to its surrounding artifacts. In Ruby closures are implemented through a Proc object, Lambda object or a block.

2, What is binding?

A closure retains the reference of its surrounding artifacts such as local variable names, methods, constants and they are called the closures binding

- The surrounding artifacts of a closure (names of variables and methods) are called its bindings

3, How does binding affect the scope of closures?

closures retain memory of their surrounding scope and can also use and update the variables in that scope when they are executed from somewhere else.

Example:

```ruby
def add_prefix
  p "Mr. " + yield
end

name = 'sabtain'

add_prefix { name.upcase } # "Mr. SABTAIN"

```
In the above code the block passed to the `add_prefix` method is executed on line xxx within `add_prefix` method and the `name` local variable is not in scope within the method. But as the block has a biniding to the local variable as it is initialized before the block so it can be referenced later by the block when it is executed within the method

4, How do blocks work?

blocks are defined by `do..end` or `{}` and passed into methods. They are unamed chunk of code and can be passed around and execute later. In order from it to be executed later it needs to retain information of its surroundiung where it is defined. The return value of the block is determined by the l;ast line of code executed within the block

5, When do we use blocks? (List the two reasons)

1. when we wan to leave some of the implementation details to the the time when the method is invoked

2. when we want to do some before and after action witihin the method. 

6, Describe the two reasons we use blocks, use examples.

The first one is when the implementor of the method wants to leave the some implementation details to the caller of the method.

example:
```ruby
[1, 2, 3, 4].select {|n| n > 2}
```
In the above example we know that select method returns a new array with a selected elements from the calling array but the selection criteria is left to the caller of the method.

Second is when there is some before and after action to be performed. The block will implement the action to be performed between before and after.

```ruby
def update_string(string)
  p string
  new_string = yield(string)
  p "#{string} is now #{new_string}"
end
```
In the above example the `string` value is outputted and then some action is performed by yielding to the block and passing in `string` as an argument and the return value is assigned to `new_string`. In the after action both the old and the return value of the block are output.

7, When can you pass a block to a method? Why?

A block can be passed to method upon invocation. Every method takes an optional block as an implicit argument. If a method is to execute the implicit block it does that with the help oif `yield` keyword. If a block is passed but the method implementation does not use the `yield` keyword no error is raised.

8, How do we make a block argument manditory?

blocks can be passed to method as an explicit argument. The method is defined with a parameter with `&`characetr prepended to it. This allows for the block passed upon method invocation to be assigned to this special parameter.
If the method implemetation uses the `yield` keyword also makes it manditory that a block is passed as an implicit argument, if not then a error is raised.

9, How do methods access both implicit and explicit blocks passed in?

The method access implicit block passed in by using the `yield` keyword and by using the `Proc#call` method the explicit block can be executed.

example:

```ruby
def some_method(&block)
  block.call # access the explicit block referenced by `block`
  yield # access the implicit block
end
```

10, What is `yield` in Ruby and how does it work?

`yield` is a keyword which is used in method definition to invoke implicit or explicit blocks passed to a method upon its invocation. `yield` accepts arguments which are passed to blocks and assigned to block local variables defined as block parameters.

11, How do we check if a block is passed into a method?

We can use the `kernel#block_given?` to ensure if a block is passed to the method. `block_given?` returns boolean true is `yield` would execute a block in the current context and false if not.

12, Why is it important to know that methods and blocks can return closures?

It is important to know that methods and blocks can return and pass closures to other methods as this allows us to access data that would usually be out of scope and pass functionality which allows to keep code DRY and flexible.
It is also important to remember that closures returned from methods and blocks that are defined within those methods and blocks will have access to the artifacts within the scope of those methods and/or blocks and so the returned closures can reference/alter those artifacts at a later time.

example:
```ruby
def some_method
  arr = []
  Proc.new do |num|
    arr << num
    arr
  end
end

p my_closure = some_method # #<Proc:0x052ac148 S:/launch_skl/RB_139/test.rb:3>
p my_closure.call #[nil]
p my_closure.call(1) #[nil, 1]
p my_closure.call('one') #[nil, 1, "one"]
```

13, What are the benifits of explicit blocks?

An explicit block is a block that gets treated as a named object, it gets assinged to a method parameter so it can be reassigned, passed to other methods, and invoked many times.

An explicit block gives additional felxiablity as now we have handle to the block, it can now be passed to other methods and can br returned as a Proc object

Example:
```ruby
def method1
  puts yield
end

method1 {"sabtain"} # sabtain

def method2(&block)
  puts block
end

method2 {"sabtain"} # #<Proc:0x05c14140 S:/launch_skl/RB_139/test.rb:11>
```

14, Describe the arity differences of blocks, procs, methods and lambdas.

Arity is the number of arguments that must be passed to a block, Proc or lambda. Blocks and Proc's have a lenient arity this is why when too less or too many arguments are passed to a block it does not raise an error. All unassigned parameters variables are set to nil

But methods and lambda have a very strict arity, which means that the number of arguments passed to a method must be equal to the arguments that it expects.


15, What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)

16, What does `&` do when in a the method parameter?

```ruby
def method(&var); end
```
In the above example the `&var` is a special parameter that converts the passed in block into a simple Proc object. The `&` is dropped when we reference the parameter within the `#method` method.

17, What does `&` do when in a method invocation argument?

```ruby
method(&var)
```
first the `&` checks if the argument passed is a Proc object and then converts it into a block. If the argument is not a Proc then it first calls the `#to_proc` on it and converts it into a Proc and then converts the Proc object to a block. If the passed in object is not a Proc and does not have `#to_proc` then an error is raised

18, What is happening in the code below?

```ruby
arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`
```
`#map` is called on the array object referenced by `arr`. `#map` methods takes a block as an argument.
Here `:to_s` symbol object is passed in and is prepended by `&` symbol. As `:to_s` is a symbol object so `&` will first call the `Symbol#to_proc`, so now we have a Proc object and the `&` will convert the Proc object to a block. A new array is returned whose elements are the elements of array refrenced by `arr` to a string.

here the `&` is going to call the `Symbol#to_proc` on `:to_s` and then convert the Proc to a block which will then be passed to the map method.

19, How do we get the desired output without altering the method or the method invocations?

```ruby
def call_this
  yield(2)
end

# your code here
to_s = :to_i
to_i = :to_s

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

20, How do we invoke an explicit block passed into a method using `&`? Provide example.

The `&` prepended to a method parameter converts it to a simple Proc object. So within the method we drop the `&` symbol and reference the parameter directly and invoke the explicit block by calling the `Proc#call` on the method local variable refrencing the Proc object. We can also invoke the block with the help of `yield` keyword.

example:

```ruby
def method(&block)
  block.call #"this is stan"
  yield # "this is stan"
end

method { puts "this is stan"}
```

21, What concept does the following code demonstrate?

```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```
This represents a snadwhich code where we only implement the before and after action. One of the reasons why we use blocks in ruby

22, What will be outputted from the method invocation `block_method('turtle')` below? Why does/doesn't it raise an error?

```ruby
def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```
The following string will be output `This is a turtle and a .`. Here the `block_method` is invoked and with string `'trurle'` argument and an implicit block. The block is defiend with two block paramters. Within the `block_method` the block is called with only one argument passed to it and no error is raised as block have a lenient arity and so the second parameter is set to `nil`. This why the output string has a empty space at the end as `nil` interploated within a string is an empty space.

23, What will be outputted if we add the follow code to the code above? Why?

```ruby
block_method('turtle') { puts "This is a #{animal}."}
```
This will raise an error as there is no `animal` local variable or method defined before the block.

24, What will the method call `call_me` output? Why?

```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```
The following string will be output `hi Griffin`. Closure keep track of its surrounding artifacts here `chunk_of_code` references a Proc object which is a closure and `name` local variable is initialized before the Proc object is created and when on line xx `name` is reassigned the proc object keeps track of it and so when the Proc object is called with the `call_me` method the string outputted reflects this.

The string outputted is `hi Griffin`. This is because the Proc object referenced by `chunk_of_code`
is bound to the local variable `name` and the changes made to it even after the Proc object is created
can be seen by it.

25, What happens when we change the code as such:

```ruby
def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```
this will raise an error as `name` local variable is initialized after the Proc object is created. Variable referenced within a block must be initialized before the block is defined.

26, What will the method call `call_me` output? Why?

```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"

def name
  "Joe"
end

chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)
```
The outputted string is `hi Robert`. As when `name` is referenced within the Proc object it first searches for a local variable `name`. As `name` local variable is defined before the Proc object is created the Proc object is bound to it.

27, Why does the following raise an error?

```ruby
def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)
```
Here `a` references a string object and the string class doesnt define a `#to_proc` method.

28, Why does the following code raise an error?

```ruby
def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)
```
This will raise an error as on line xx as a block is begin assinged to a local variable which is not possible as blocks are not obejcts.

29, Why does the following code output `false`?

```ruby
def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)
```
within `some_method` `#block_given?` returns false as no block is passed upon the `some_method` invocatioa on line xxx. We can make it return true if we prepend the `bloc` argument on line xx with `&` and prepend the `block` parameter with `&`.


30, How do we fix the following code so the output is `true`? Explain

```ruby
def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc)
```

31, How does `Kernel#block_given?` work?
It returns boolean `true` is `yield` will execute a block in the given context and boolean flase otherwise.

32, Why do we get a `LocalJumpError` when executing the below code? &
How do we fix it so the output is `hi`? (2 possible ways)

```ruby
def some(block)
  yield
end

bloc = proc { p "hi" } # do not alter

some(bloc)
```
the error is raised as within the `some` method `yield` keyword is used but no block is passed upon method invocation

```ruby
#one way
def some(&block)
  yield
end

bloc = proc { p "hi" } # do not alter

some(&bloc)
```
```ruby
#second way
def some(block)
  yield if block_given
end

bloc = proc { p "hi" } # do not alter

some(bloc)
```

33, What does the following code tell us about lambda's? (probably not assessed on this but good to know)

```ruby
bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

34, What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assessed on this, but good to know ;)

```ruby
def lambda_return
  puts "Before lambda call."
  lambda {return}.call
  puts "After lambda call."
end

def proc_return
  puts "Before proc call."
  proc {return}.call
  puts "After proc call."
end

lambda_return #=> "Before lambda call."
              #=> "After lambda call."

proc_return #=> "Before proc call."

```

35, What will `#p` output below? Why is this the case and what is this code demonstrating?

```ruby
def retained_array
  arr = []
  Proc.new do |el|
    arr << el
    arr
  end
end

arr = retained_array
arr.call('one')
arr.call('two')
p arr.call('three')
```
It will output `['one', 'two', 'three']`.
this demonstrates that methods can return closures to sepcific Proc object and that closures defined within a method are bound its surrounding artifacts defined within the method and can be altered later when the closure is executed

Here `arr` refrences the return value of the method call `retained_array` which is a proc object.
The Proc object referenced by `arr` is called using the `#call` and passing arguments to it which mutate the `arr` defined in the method `retained_array` which is not in scope outside the method.

# TESTING WITH MINITEST

36, What is a test suite?

It is all the tests that go along with our program or application. It is a set of tests.

37, What is a test?

It is the state or circumstances in which a test is run. For example, a test will raise an error if input is a string. A test may contain multiple assertions

38, What is an assertion?

This is the step that verifies that the data returned by our application or program is what was expected.

39, What do testing framworks provide?
They provide a way to describe the test rquired. They provide a way to execute those test and provide a way to report/display results.

40, What are the differences of Minitest vs RSpec
RSpec is a DSL (domain specific language) for writing test.
Minitest is the default library that comes along Ruby and it provides a simpler syntax which is just Ruby code and can do everything that Rspec can do.
Minitest can also use a DSL.

41, What is Domain Specific Language (DSL)?

DSL is a programming language and which is specific

42, What is the difference of assertion vs refutation methods?
assertion methods test to see if things are same or truthy and refutaion method test to see if things are not the same or falsy.

43, How does assert_equal compare its arguments?
assert_eqal tests for value equality. To be specific it calls the `#==` on the objects

44, What is the SEAT approach and what are its benefits?

SEAT has four steps to it.
S: setup the necessary objects
E: execute the code against the object we are testing
A: assert that the executed code did the right thing
T: teardown and clean up any lingering artifacts

45, When does setup and tear down happen when testing?

The setup instance method is called before each test is run and teardown instance method is called after each test is run.

46, What is code coverage?

It is the precentage of how much of our program code is tested by a test suite.

47, What is regression testing?

Testing for bugs after an update is made to a program which was working correctly before to ensure that the whole program continues to work correctly.b

# CORE TOOLS

48, What are the purposes of core tools?

Ruby core tools help developers develop, maintain, launch, streamline and automate code.

49, What are RubyGems and why are they useful?

Gems are pacakages of code to be used in our program or command line wich provide functionality originally not included in ruby.

50, What are Version Managers and why are they useful?

Version managers lets us control which version of ruby we want to use and provide us to work on different versions of ruby as per project requirements without conflict. It lets us install different versions and use the version required and we lets us know which version is currently begin used.

51, What is Bundler and why is it useful?

bundler uses a file named `Gemfile` to install dependencies for our project. It make sures that we are using the correct version of ruby, gems, rake ect, as mention in the `Gemfile`. It installs the required dependencies and makes sure that the correct version is begin used as required by a specific project.

52, What is Rake and why is it useful?

Rake is Gem that helps streamline project management and development by automating task when building, maintaining, testing, packaging and installing.


53, What constitues a Ruby project?