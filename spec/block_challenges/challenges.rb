require 'spec_helper'
require 'block_challenges'

class PrimitiveArray
  def self.[](*elements)
    new elements
  end

  def initialize(real_array)
    @real_array = real_array
  end

  def inspect
    "PrimitiveArray#{@real_array.inspect}"
  end

  def [](i)
    @real_array[i]
  end

  def length
    @real_array.length
  end
end


class ArrayWithOnlyEach
  def self.[](*elements)
    new elements
  end

  def initialize(real_array)
    @real_array = real_array
  end

  def inspect
    @real_array.inspect
  end

  def each(&block)
    i = 0
    while i < @real_array.length
      block.call @real_array[i]
      i += 1
    end
    self
  end
end

__END__
'block_and_forth_forever receives a block, and calls it with a block that doubles whatever it receives'
results = []
block_and_forth_forever do |&block|
  results << block.call(3)
  results << block.call(2)
  results << block.call(1)
end
assert_equal [3, 2, 1], results


'blinked_list_unshift returns a block where, if I call it with :data, it gives me the data, and if I call it with :link, it gives me the original block'
  'blinked_list_data returns the data, if there is a node'
  'blinked_list_link returns the link, if there is a node'
  list = blinked_list_unshift 1, nil
  list = blinked_list_unshift 'a', list
  list = blinked_list_unshift :lol, list
  list.call(:data) # => :lol
  list.call(:link).call(:datta) # => "a"
  list.call(:link).call(:link).call(:datta) # => 1
  list.call(:link).call(:link).call(:link) # => nil

  blinked_list_data list # => :lol
  list = blinked_list_link list
  blinked_list_data list # => "a"
  list = blinked_list_link list
  blinked_list_data list # => 1
  list = blinked_list_link list
  assert_equal nil, list
