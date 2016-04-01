require 'iterable/challenge'

RSpec.describe 'Ooll - Object Oriented Linked List' do
  let(:list) { Ooll.new }

  describe 'bootstrapping #[] and #unshift' do
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
      list.unshift('a')
      assert_equal nil, list[1]
      assert_equal nil, list[2]
      list.unshift('b')
      assert_equal nil, list[2]
    end
  end

  describe '#shift' do
    it 'returns the first item' do
      assert_equal 'a', list.unshift('a').shift
      assert_equal 'b', list.unshift('b').shift
    end

    it 'removes the first item' do
      list.unshift('a').unshift('b').unshift('c').unshift('d').unshift('e').unshift('f')
      assert_equal 'f', list.shift
      assert_equal 'e', list.shift
      assert_equal 'd', list.shift
      assert_equal 'c', list.shift
      assert_equal 'b', list.shift
      assert_equal 'a', list.shift
    end

    it 'returns nil if there are no items in the list' do
      assert_equal nil, list.shift
    end
  end


  describe '#<<' do
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


  describe '#pop' do
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


  describe '#join' do
    it 'returns an empty string when given an empty list' do
      assert_equal '', list.join
      assert_equal '', list.join("-")
    end
    it 'returns its head\'s to_s when it only has a head' do
      list << 123
      assert_equal '123', list.join
      assert_equal '123', list.join("-")
    end
    it 'returns each of its items to_s, concatenated, with given delimiter' do
      list << 'abc' << 123 << :lol
      assert_equal 'abc-123-lol',   list.join("-")
      assert_equal 'abc, 123, lol', list.join(", ")
    end
    it 'defaults the delimiter to an empty string' do
      list << 'abc' << 123 << :lol
      assert_equal 'abc123lol', list.join
    end
    it 'uses an empty string as a delimiter, if the delimiter is nil' do
      list << 1 << 2 << 3
      assert_equal '123', list.join(nil)
      assert_equal '123', [1,2,3].join(nil) # We're just matching the Array interface
    end
    it 'uses the result of to_str, if the delimiter is not a string, and has a to_str method' do
      list << 1 << 2 << 3
      dot = Object.new
      def dot.to_str() '.' end
      assert_equal '1.2.3', list.join(dot)
      assert_equal '1.2.3', [1,2,3].join(dot) # We're just matching the Array interface
    end
    it 'raises a TypeError if to_str returns something that isn\'t a String' do
      list << 1 << 2 << 3
      bad_delim = Object.new
      def bad_delim.to_str() :not_a_string end
      assert_raises(TypeError) { [1,2,3].join(bad_delim) } # make sure Array does something simliar
      assert_raises(TypeError, "can't convert Object to String (Object#to_str gives Symbol)") do
        list.join(bad_delim)
      end
    end
    it 'raises a TypeError of the delimiter isn\'t a string and doesn\'t have a to_str method' do
      list << 1 << 2 << 3
      bad_delim = Object.new
      assert_raises(TypeError) { [1,2,3].join bad_delim } # make sure Array does something simliar
      assert_raises(TypeError, 'no implicit conversion of Object into String') do
        list.join bad_delim
      end
    end
  end


  describe '#==' do
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
