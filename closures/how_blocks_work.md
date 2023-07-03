## How blocks work, and when we want to use them

Blocks are passed as arguments to method calls. What the method does with the block or chunk of code passed to it is up to the method implementation.

In Ruby every method can take an optional block as an implicit argument. The block passed in as an argument can be invoked from within the method with help of the `yeild` keyword.

If a method implementation uses a `yeild` keyword and a block is not passed at method invocation this raises the `LocalJump` error. This error can be taken care of by wrapping the `yield` keyword in a conditional so that yeild is called only when a block is passed. This is acheived through `Kernel#block_given?`.

Blocks are used when we want allow some felxibilty at method invocation time.

Blocks have a return value just like methods do, which is determined by the last expression in the block.

There are two main use cases to use blocks.

1) to defer some implementation code to method invocation descision.

The code implementator leaves some felxability for the method user to refine the method through a block at invocation time.

For example many of the methods in the core libaray of Ruby have method like `Array#select`. They are implemenated in a generic way and the selection criteria is provided by the method user through a block at invocation time. This provides felxability for the method user by allowing the user to provide refinment to the method implementation.

So, if there is a case where a method is beign called from multiple places with little changes for each case, it is a better idea to implement the method in a generic way by yielding to a block.

2) Methods that need to perform some before and after action-sandwhich code.

This a secaniro where we need to implement a generic method that performs some before and after action. The implemenator of the method does not care for the action beign performed which is left upto the method user.

There are many useful cases for "sandwhich code" such as Timing a task, logging, notification systems are all examples where before and after actions are important.

An example of this is the `File::open` method does. it takes a block in which the method user interacts with the file. So the `File::open` is implemeted in a way that when the method is called the file name passed in as an argument is first opened then the method yileds to the block after which the file is closed.
