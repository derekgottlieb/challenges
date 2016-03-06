require 'iterable/challenge'

RSpec.describe 'Ooll - Object Oriented Linked List' do
  let(:list) { Ooll.new }

  specify 'bracket access on an empty list returns nil' do
    assert_equal nil, list[0]
    assert_equal nil, list[1]
    assert_equal nil, list[2]
  end

  specify 'unshift returns the list' do
    assert_equal list, list.unshift("a")
  end

  specify 'unshift adds an item to the front, brackets at 0 returns the item at the front' do
    assert_equal "a", list.unshift("a")[0]
    assert_equal "b", list.unshift("b")[0]
  end

  specify 'unshift moves the item that used to be at the front to the second position, brackets at 1 returns the second position' do
    assert_equal "a", list.unshift('a').unshift('b')[1]
  end

  specify 'this continues indefinitely far out' do
    list.unshift('a').unshift('b').unshift('c').unshift('d').unshift('e').unshift('f')
    assert_equal 'f', list[0]
    assert_equal 'e', list[1]
    assert_equal 'd', list[2]
    assert_equal 'c', list[3]
    assert_equal 'b', list[4]
    assert_equal 'a', list[5]
  end

  specify 'brackets return nil if asked for an item past the end of the list' do
    assert_equal nil, list[0]
    assert_equal nil, list[1]
    assert_equal nil, list[2]
    list << 'a'
    assert_equal nil, list[1]
    assert_equal nil, list[2]
    list << 'b'
    assert_equal nil, list[2]
  end

  describe 'shift' do
    specify 'shift returns the first item' do
      assert_equal 'a', list.unshift('a').shift
      assert_equal 'b', list.unshift('b').shift
    end

    specify 'shift removes the first item' do
      list.unshift('a').unshift('b').unshift('c').unshift('d').unshift('e').unshift('f')
      assert_equal 'f', list.shift
      assert_equal 'e', list.shift
      assert_equal 'd', list.shift
      assert_equal 'c', list.shift
      assert_equal 'b', list.shift
      assert_equal 'a', list.shift
    end

    specify 'shift returns nil if there are no items in the list' do
      assert_equal nil, list.shift
    end
  end


  describe 'shovel' do
    it 'returns the list' do
      assert_equal list, (list << 'a')
    end

    it 'adds an item to the end of the list' do
      list << 'a' << 'b' << 'c' << 'd' << 'e' << 'f'
      assert_equal 'a', list[0]
      assert_equal 'b', list[1]
      assert_equal 'c', list[2]
      assert_equal 'd', list[3]
      assert_equal 'e', list[4]
      assert_equal 'f', list[5]
    end
  end


  describe 'pop' do
    it 'returns the item at the end of the list' do
      list << "a" << "b" << "c"
      assert_equal 'c', list.pop
    end

    it 'returns nil if there are no items in the list' do
      assert_equal nil, list.pop
    end

    describe 'removes the item at the end of the list' do
      example 'when there is only one item' do
        list << 'a'
        assert_equal 'a', list.pop
        assert_equal nil, list[0]
      end

      example 'when there are two items' do
        list << 'a' << 'b'
        assert_equal 'b', list.pop
        assert_equal 'a', list.pop
        assert_equal nil, list.pop
      end

      example 'when there are many items' do
        list << 'a' << 'b' << 'c' << 'd' << 'e' << 'f'
        assert_equal 'f', list.pop
        assert_equal 'e', list.pop
        assert_equal 'd', list.pop
        assert_equal 'c', list.pop
        assert_equal 'b', list.pop
        assert_equal 'a', list.pop
        assert_equal nil, list.pop
      end
    end
  end


  describe '==' do
    it 'returns false if compared to a non-list' do
      list << 'a' << 'b' << 'c'
      assert_equal false, (list == 'abc')
    end

    it 'returns true if both lists are empty' do
      assert_equal Ooll.new, Ooll.new
    end

    it 'returns true if all the elements are the same' do
      list1 = Ooll.new << 'a' << 'b' << 'c'
      list2 = Ooll.new << 'a' << 'b' << 'c'
      assert_equal true, (list1 == list2)
    end

    it 'returns false if the left list has fewer elements' do
      list1 = Ooll.new << 'a' << 'b'
      list2 = Ooll.new << 'a' << 'b' << 'c'
      assert_equal false, (list1 == list2)
    end

    it 'returns false if the right list has fewer elements' do
      list1 = Ooll.new << 'a' << 'b' << 'c'
      list2 = Ooll.new << 'a' << 'b'
      assert_equal false, (list1 == list2)
    end

    it 'returns false if any of the elements are not ==' do
      list1 = Ooll.new << 'a' << 'B' << 'c'
      list2 = Ooll.new << 'a' << 'b' << 'c'
      assert_equal false, (list1 == list2)
    end

    it 'does not modify the lists' do
      list1 = Ooll.new << 'a' << 'b' << 'c'
      list2 = Ooll.new << 'a' << 'x' << 'c'
      list1 == list2
      assert_equal ['a', 'b', 'c', 'a', 'x', 'c'],
                   [ list1.shift, list1.shift, list1.shift,
                     list2.shift, list2.shift, list2.shift,
                   ]
    end
  end
end
