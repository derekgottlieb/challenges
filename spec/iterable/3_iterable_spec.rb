require 'iterable/challenge'


RSpec.describe 'Iterable' do
  specify 'I have doen parts 1 and 2' do
    i_see_this_helpful_stuff_here true
  end

  specify 'I\'m ultimately building my own Enumerable module, for my list instead of arrays' do
    i_see_this_helpful_stuff_here true
  end

  specify 'I\'m able to define each and map for array' do
    # https://vimeo.com/156462575
    i_see_this_helpful_stuff_here true
  end

  # only uses each
  def assert_enum(list, method_name, *args, expected, &block)
    actual = list.__send__(method_name, *args, &block)
    assert_equal expected, actual
  end

  specify 'to_a returns an array of the items iterated over' do
    assert_enum Ooll[1,2,2], :to_a, [1,2,2]
  end

  describe 'count' do
    specify 'returns how many items the block returns true for' do
      assert_enum(Ooll[],              :count, 0) { true }
      assert_enum(Ooll['a', 'a'],      :count, 2) { true }
      assert_enum(Ooll['a', 'b', 'a'], :count, 2) { |char| char == 'a' }
    end

    specify 'returns how many items are in the array, if no block is given' do
      assert_enum Ooll[],         :count, 0
      assert_enum Ooll['a'],      :count, 1
      assert_enum Ooll['a', 'a'], :count, 2
    end
  end

  specify 'find returns the first item where the block returns true' do
    assert_enum(Ooll[],                       :find,   nil) { true }
    assert_enum(Ooll[1, 2],                   :find,     1) { true }
    assert_enum(Ooll['a', 'bcd', 'a', 'xyz'], :find, 'bcd') { |str| str.length == 3 }
    assert_enum(Ooll[1, 2],                   :find,   nil) { false }
  end

  specify 'find_all returns all the items where the block returns true' do
    assert_enum(Ooll[], :find_all, Ooll[]) { true }
    assert_enum(Ooll[], :find_all, Ooll[]) { false }

    ary = Ooll[1,2,1,3,2,6]
    assert_enum(ary, :find_all,       ary) { true }
    assert_enum(ary, :find_all,        Ooll[]) { false }
    assert_enum(ary, :find_all, Ooll[1, 1, 3]) { |i| i.odd? }
    assert_enum(ary, :find_all, Ooll[2, 2, 6]) { |i| i.even? }
  end

  specify 'map returns an array of elements that have been passed through the block' do
    assert_enum(Ooll[],         :map,         Ooll[]) { 1 }
    assert_enum(Ooll['a', 'b'], :map,     Ooll[1, 1]) { 1 }
    assert_enum(Ooll['a', 'b'], :map, Ooll['A', 'B']) { |char| char.upcase }
  end

  describe 'inject' do
    it 'passes an aggregate value through the block, along with each element' do
      assert_enum(Ooll[],     :inject, 0,  0) { |sum, num| sum + num }
      assert_enum(Ooll[5, 8], :inject, 0, 13) { |sum, num| sum + num }
      assert_enum(Ooll[5, 8], :inject, 1, 14) { |sum, num| sum + num }

      assert_enum(Ooll['a', 'b'], :inject, '', 'ab') { |str, char| str + char }
    end

    it 'can take a symbol, and call the method of that name in place of the block' do
      assert_enum(Ooll[],     :inject, 0, :+, 0)
      assert_enum(Ooll[5, 8], :inject, 0, :+, 13)
    end

    it 'prefers the symbol to the block' do
      assert_enum(Ooll[5, 8], :inject, 1, :+, 14) { |product, num| product * num }
    end
  end

  describe 'first' do
    specify 'returns the first item in the collection' do
      assert_enum(Ooll[], :first, nil)
      assert_enum(Ooll[1], :first, 1)
      assert_enum(Ooll[1, 2], :first, 1)
    end

    specify 'delegates to take, if given a number to take' do
      assert_enum Ooll[1,2,3], :first, 2, Ooll[1,2]
    end
  end

  specify 'all? returns true if the block returns true for each item in the array' do
    assert_enum(Ooll[],  :all?, true) { true }
    assert_enum(Ooll[],  :all?, true) { false }
    assert_enum(Ooll[1], :all?, true) { 1 }
    assert_enum(Ooll[1], :all?, true) { |n| n == 1 }
    assert_enum(Ooll[1], :all?, false) { |n| n == 2 }
    assert_enum(Ooll[1, 2], :all?, false) { |n| n == 2 }
    assert_enum(Ooll[1, 2], :all?, true) { |n| n < 3 }
  end

  specify 'any? returns true if the block returns true for any item in the array' do
    assert_enum(Ooll[],     :any?, false) { true }
    assert_enum(Ooll[],     :any?, false) { false }
    assert_enum(Ooll[1],    :any?, true) { 1 }
    assert_enum(Ooll[1],    :any?, true) { |n| n == 1 }
    assert_enum(Ooll[1],    :any?, false) { |n| n == 2 }
    assert_enum(Ooll[1, 2], :any?, true) { |n| n == 2 }
    assert_enum(Ooll[1, 2], :any?, false) { |n| n < 0 }
  end

  specify 'none? returns true if the block returns false for each item in the array' do
    assert_enum(Ooll[],     :none?, true)  { true }
    assert_enum(Ooll[],     :none?, true)  { false }
    assert_enum(Ooll[1],    :none?, false) { 1 }
    assert_enum(Ooll[1],    :none?, false) { |n| n == 1 }
    assert_enum(Ooll[1],    :none?, true)  { |n| n == 2 }
    assert_enum(Ooll[1, 2], :none?, false) { |n| n == 2 }
    assert_enum(Ooll[1, 2], :none?, true)  { |n| n < 0 }
  end


  describe 'min_by' do
    it 'returns the smallest element, compared by the return values from the block' do
      assert_enum(Ooll[],           :min_by,   nil) { |s| s }
      assert_enum(Ooll['z', 'abc'], :min_by, 'abc') { |s| s }
      assert_enum(Ooll['abc', 'z'], :min_by,   'z') { |s| s.length }
      assert_enum(Ooll['abc', 'z'], :min_by, 'abc') { |s| s }
      assert_enum(Ooll[nil, false], :min_by,   nil) { |bool| bool == nil ? -1 :  1  }
      assert_enum(Ooll[nil, false], :min_by, false) { |bool| bool == nil ?  1 : -1  }
    end

    it 'returns the first seen, when there are multiple results with the same value' do
      assert_enum(Ooll['a', 'b'], :min_by, 'a') { 1 }
      assert_enum(Ooll['b', 'a'], :min_by, 'b') { 1 }
    end
  end


  describe 'max_by' do
    it 'returns the largest element, compared by the return values from the block' do
      assert_enum(Ooll[],           :max_by,   nil) { |s| s }
      assert_enum(Ooll['z', 'abc'], :max_by,   'z') { |s| s }
      assert_enum(Ooll['abc', 'z'], :max_by, 'abc') { |s| s.length }
      assert_enum(Ooll['abc', 'z'], :max_by,   'z') { |s| s }
      assert_enum(Ooll[nil, false], :max_by, false) { |bool| bool == nil ? -1 :  1  }
      assert_enum(Ooll[nil, false], :max_by,   nil) { |bool| bool == nil ?  1 : -1  }
    end

    it 'returns the first seen, when there are multiple results with the same value' do
      assert_enum(Ooll['a', 'b'], :max_by, 'a') { 1 }
      assert_enum(Ooll['b', 'a'], :max_by, 'b') { 1 }
    end
  end

  specify 'include? returns true if the item is in the collection' do
    assert_enum Ooll[],     :include?, 1, false
    assert_enum Ooll[1],    :include?, 1, true
    assert_enum Ooll[2, 1], :include?, 1, true
    assert_enum Ooll[1, 2], :include?, 1, true

    assert_enum Ooll[1],    :include?, 3, false
    assert_enum Ooll[2, 1], :include?, 3, false
  end

  specify 'each_with_object hands the block the item, and an object, and returns the object' do
    assert_enum(Ooll[], :each_with_object, '', '') { }

    assert_enum(Ooll['a', 'b'], :each_with_object, '', 'ab') do |char, string|
      string << char
      nil
    end
  end

  specify 'take returns the first available n items' do
    assert_enum(Ooll[],              :take, 1, Ooll[])
    assert_enum(Ooll[1],             :take, 0, Ooll[])
    assert_enum(Ooll[1],             :take, 1, Ooll[1])
    assert_enum(Ooll[1,2],           :take, 1, Ooll[1])
    assert_enum(Ooll['a', 'b', 'c'], :take, 2, Ooll['a', 'b'])
  end

  specify 'drop returns whatever items wouldn\'t get taken by take' do
    assert_enum(Ooll[],              :drop, 1, Ooll[])
    assert_enum(Ooll[1],             :drop, 0, Ooll[1])
    assert_enum(Ooll[1],             :drop, 1, Ooll[])
    assert_enum(Ooll[1,2],           :drop, 1, Ooll[2])
    assert_enum(Ooll['a', 'b', 'c'], :drop, 2, Ooll['c'])
  end
end
