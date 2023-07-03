# Assertions


assert(test)                     Fails unless test is truthy.
assert_equal(exp, act)           Fails unless exp == act.
assert_nil(obj)                  Fails unless obj is nil.
assert_raises(exp) { ... }      Fails unless block raises one of exp.
assert_instance_of(cls, obj)      Fails unless obj is an instance of cls.
assert_includes(collection, obj)  Fails unless collection includes obj
assert_empty(collection)          Fails unless collection is not empty
assert_same(obj1, obj2)           Fails unless obj1 and obj2 are the same objects
assert_kind_of(cls, obj)          Fails unless obj is an instance of cls or its subclasses

## Testing equality

When we use `assert_equal` we are testing for value equality. To be specific the `==` is begin invoked on the obejct. If we wanted to test a strict object equality then go for `assert_same` assertion.

As all Ruby core library classes implement a sensible `==` to test for vlaue equality, so we can get away with uing `assert_equal` with Array, Strings, Hashes etc. But when it comes to using assert_equal on a custom class we have to tell Minitest how to compare those objects by implemnting the `==` in our custom class.