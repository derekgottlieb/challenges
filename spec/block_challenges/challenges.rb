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
