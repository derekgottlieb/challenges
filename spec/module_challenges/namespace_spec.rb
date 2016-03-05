require 'module_challenges/challenges'

# to add: using toplevel scope resolution operator
RSpec.describe 'modules as namespaces' do
  # create a module MahMod
  #   it should be defined on Object
  #   it should be a module
  # create a module within it MahMod::A
  # create a module within it MahMod::B
  # create a module within it MahMod::A::C with a value of 1
  # create a module within it MahMod::B::C with a value of 2
  # "lookup the constant C on the argument you're given"

  # dynamically create a module by instantiating the class Module

  # create a class it MahMod::List
  #   It will create a linked list using constants
  #   array = MahMod::List.new
  #   array.unshift "a"
  #   array.head::DATA # => "a"
  #   array.head::LINK # => nil
  #   array.unshift "b"
  #   array.head::DATA # => "b"
  #   array.head::LINK::DATA # => "a"
  #   array.head::LINK::LINK # => nil
  #   array.unshift "c"
  #   array.head::DATA # => "c"
  #   array.head::LINK::DATA # => "b"
  #   array.head::LINK::LINK::DATA # => "a"
  #   array.head::LINK::LINK::LINK # => nil

  # Save the toplevel String class at MahMod::String
  # Save your MahMod::List class at the constant MahMod::Array
  # Use a leading scope resolution operator to return the real array and your array
end
