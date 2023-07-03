# Symbol to block

When working with collection we may want to transform all the elements in the collection.

```ruby
['1', '2', '3', '4'].map(&:to_i)

# [1, 2, 3, 4]

```
In the above example the each element in the calling collection is transformed into an integer. The above code iterates through every element in the calling array and calls `#to_i` on it and saves the result in a new array. After the iteration is completed the new array is returned.

so the `&` must be followed by a symbol name for a method that can be invoked on each element.

This shortcut only works for methods that do not take arguments. This shortcut works with any collection method that takes a block.

## Symbol#to_proc

if we look closely, the below code

```ruby
(&:to_i)
```
get converted to this code

```ruby
{ |n| n.to_i }
```
In this case we are applying `&` to some object, when this happens Ruby tries to convert that object to a block. Ruby converts Proc objects to blocks naturally. But if the object is not already a Proc we have to convert it to a Proc. To do so we need to call the `#to_proc` on the object, and so a Proc object is returned. So now Ruby can convert the resulting Proc to a block.

Lets break it down set by step.

`&:to_i` tells Ruby to convert the Symbol `:to_i` into a block
As `:to_i` is not a Proc, Ruby first calls the `Symbol#to_proc` to convert the symbol to Proc
Now it is a Proc so Ruby converts this Proc to a block.

below are some examples.

```ruby
def my_method
  yield('2')
end

p my_method(&:to_i) # 2

```

In below example we wil break it down into 2 steps

```ruby
def my_method
  yield('2')
end

a_proc = :to_i.to_proc # explicitly call `#to_proc` on symbol object

p my_method(&a_proc) # convert Proc into block. then pass in the block. Returns 2
```