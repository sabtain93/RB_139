# SEAT approch

There are four steps to writing a test:

1. Set up the necessary objects.
2. Execute the code against the object we are testing
3. Assert that the executed code did the right thing
4. Tear down and clean up any lingering artifacts.


setting up ncessary objects is so redundant that we define a `#setup` instance method. The `#setup` is called before running every test. We use instance variables and not local variables which reference the objects that are setup, as instance variables are available in the test instance methods.

The `#teardown` instance method is called after running every test. Tear down is used for cleaning up files or logging some information, or closing database connections.