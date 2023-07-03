def some_method
  block_given?
end

bloc = proc { puts "hi" }

p some_method(&bloc)