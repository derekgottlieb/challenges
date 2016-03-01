require 'spec_helper'
require 'linked_list_functions/classes'
require 'linked_list_functions'


RSpec.describe 'linked list functions -- (a function is a method that just works on its arguments and not on ivars)' do
  describe 'first_item' do
    it 'returns nil for an empty list' do
      list = LinkedList.new()
      assert_equal nil, first_item(list)
    end

    it 'returns the data of the first item, when there is one item' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", first_item(list)
    end


    it 'returns the data of the first item, when there is more than one item' do
      list = LinkedList.new(Node.new(:lol, Node.new(:wtf, Node.new(:bbq, nil))))
      assert_equal :lol, first_item(list)
    end
  end



  describe 'unshift' do
    it 'inserts an item at the head of the list' do
      list = LinkedList.new

      unshift_list(list, "b")
      expected = LinkedList.new(Node.new("b", nil))
      assert_equal expected, list

      unshift_list(list, 1)
      expected = LinkedList.new(Node.new(1, Node.new("b", nil)))
      assert_equal expected, list
    end

    it 'returns the list itself' do
      list = LinkedList.new
      assert_equal list, unshift_list(list, "b")
    end
  end


  describe 'shift_item' do
    it 'returns nil when the list is empty' do
      list = LinkedList.new
      assert_equal nil, shift_item(list)
      assert_equal LinkedList.new, list
    end

    it 'returns the first item when there is an element in the list' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", shift_item(list)
      assert_equal LinkedList.new, list
    end

    it 'removes the first item from the list' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", shift_item(list)
      assert_equal nil, shift_item(list)
    end

    example 'a bigger example' do
      list = LinkedList.new(Node.new(:abc, Node.new(:def, Node.new(:ghi, nil))))
      assert_equal :abc, shift_item(list)
      assert_equal LinkedList.new(Node.new(:def, Node.new(:ghi, nil))), list
      assert_equal :def, shift_item(list)
      assert_equal LinkedList.new(Node.new(:ghi, nil)), list
      assert_equal :ghi, shift_item(list)
      assert_equal LinkedList.new, list
      assert_equal nil,  shift_item(list)
    end
  end




  describe 'list_size' do
    it 'is 0 for an empty list' do
      list = LinkedList.new
      assert_equal 0, list_size(list)
    end

    it 'is 1 for a list with one item' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal 1, list_size(list)
    end

    it 'is 2 for a list with two items' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal 2, list_size(list)
    end

    it 'is 3 for a list with three items' do
      list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
      assert_equal 3, list_size(list)
    end

    it 'does not care what is in the list' do
      list = LinkedList.new(Node.new("c", Node.new("b", Node.new("a", nil))))
      assert_equal 3, list_size(list)
    end
  end



  describe 'last_item' do
    it 'returns nil for an empty list' do
      list = LinkedList.new()
      assert_equal nil, last_item(list)
    end

    it 'returns the first item when there is only one' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", last_item(list)
    end

    it 'returns the last item when there is more than one' do
      list = LinkedList.new(Node.new(:lol, Node.new(:wtf, Node.new(:bbq, nil))))
      assert_equal :bbq, last_item(list)
    end
  end



  describe 'smallest_item' do
    it 'returns nil for the empty list' do
      list = LinkedList.new
      assert_equal nil, smallest_item(list)
    end

    it 'returns the first item when there is only one' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", smallest_item(list)
    end

    describe 'returns the item that is less than the others, when there is more than one' do
      example '("a" -> "b" -> "c") returns "a"' do
        list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
        assert_equal "a", smallest_item(list)
      end

      example '("a" -> "c" -> "b") returns "a"' do
        list = LinkedList.new Node.new("a", Node.new("c", Node.new("b", nil)))
        assert_equal "a", smallest_item(list)
      end

      example '("b" -> "a" -> "c") returns "a"' do
        list = LinkedList.new Node.new("b", Node.new("a", Node.new("c", nil)))
        assert_equal "a", smallest_item(list)
      end

      example '("b" -> "c" -> "a") returns "a"' do
        list = LinkedList.new Node.new("b", Node.new("c", Node.new("a", nil)))
        assert_equal "a", smallest_item(list)
      end

      example '("c" -> "b" -> "a") returns "a"' do
        list = LinkedList.new Node.new("c", Node.new("b", Node.new("a", nil)))
        assert_equal "a", smallest_item(list)
      end

      example '("c" -> "a" -> "b") returns "a"' do
        list = LinkedList.new Node.new("c", Node.new("a", Node.new("b", nil)))
        assert_equal "a", smallest_item(list)
      end

      example '(100 -> 45 -> 300)  returns 45' do
        list = LinkedList.new Node.new(100, Node.new(45, Node.new(300, nil)))
        assert_equal 45, smallest_item(list)
      end
    end
  end



  describe 'largest_item' do
    it 'returns nil for the empty list' do
      list = LinkedList.new
      assert_equal nil, largest_item(list)
    end

    it 'returns the first item when there is only one' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", largest_item(list)
    end

    describe 'returns the item that is less than the others, when there is more than one' do
      example '("a" -> "b" -> "c") returns "c"' do
        list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
        assert_equal "c", largest_item(list)
      end

      example '("a" -> "c" -> "b") returns "c"' do
        list = LinkedList.new Node.new("a", Node.new("c", Node.new("b", nil)))
        assert_equal "c", largest_item(list)
      end

      example '("b" -> "a" -> "c") returns "c"' do
        list = LinkedList.new Node.new("b", Node.new("a", Node.new("c", nil)))
        assert_equal "c", largest_item(list)
      end

      example '("b" -> "c" -> "a") returns "c"' do
        list = LinkedList.new Node.new("b", Node.new("c", Node.new("a", nil)))
        assert_equal "c", largest_item(list)
      end

      example '("c" -> "b" -> "a") returns "c"' do
        list = LinkedList.new Node.new("c", Node.new("b", Node.new("a", nil)))
        assert_equal "c", largest_item(list)
      end

      example '("c" -> "a" -> "b") returns "c"' do
        list = LinkedList.new Node.new("c", Node.new("a", Node.new("b", nil)))
        assert_equal "c", largest_item(list)
      end

      example '(100 -> 45 -> 300)  returns 300' do
        list = LinkedList.new Node.new(100, Node.new(45, Node.new(300, nil)))
        assert_equal 300, largest_item(list)
      end
    end
  end



  describe 'get_item' do
    it 'returns nil when asked for an item in an empty list' do
      list = LinkedList.new
      assert_equal nil, get_item(list, 0)
    end

    it 'returns nil when asked for an item well into an empty list' do
      list = LinkedList.new
      assert_equal nil, get_item(list, 5)
    end

    it 'returns nil when asked for an item past the end of a list with items in it' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal nil, get_item(list, 1)
    end

    it 'returns nil when asked for an item well past the end of a list with items in it' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal nil, get_item(list, 100)
    end

    it 'finds the first item when asked for index 0' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal 'a', get_item(list, 0)
    end

    it 'finds the first item when asked for index 1' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal 'b', get_item(list, 1)
    end

    it 'finds each item in a long list' do
      list = LinkedList.new(Node.new("c", Node.new("b", Node.new("a", nil))))
      assert_equal 'c', get_item(list, 0)
      assert_equal 'b', get_item(list, 1)
      assert_equal 'a', get_item(list, 2)
      assert_equal nil, get_item(list, 3)
    end
  end



  describe 'add_item' do
    context 'when told to insert at position 0' do
      it 'adds a new node at the head' do
        list = LinkedList.new
        add_item(list, 0, "b")
        assert_equal Node, list.head.class
      end
      it 'sets that node\'s data to the inserted data' do
        list = LinkedList.new
        add_item(list, 0, "b")
        assert_equal "b", list.head.data
      end
      it 'sets the old head as that node\'s link' do
        list = LinkedList.new
        add_item(list, 0, "b")
        assert_equal nil, list.head.link

        list = LinkedList.new(Node.new("c", nil))
        add_item(list, 0, "b")
        assert_equal "c", list.head.link.data
      end
      it 'returns the list' do
        list = LinkedList.new(Node.new("c", nil))
        assert_equal list, add_item(list, 0, "b")
      end
    end

    context 'when told to insert at a position other than 0, and there is a node there' do
      it 'adds a new node at the specified index' do
        list = LinkedList.new(Node.new("x", Node.new("y", Node.new("z", nil))))
        add_item(list, 2, "O.o")
        assert_equal Node, list.head.link.link.class
      end
      it 'sets that node\'s data to the inserted data' do
        list = LinkedList.new(Node.new("x", Node.new("y", Node.new("z", nil))))
        add_item(list, 2, "O.o")
        assert_equal "O.o", list.head.link.link.data
      end
      it 'sets the node that used to be at that position as that node\'s link' do
        list = LinkedList.new(Node.new("x", Node.new("y", Node.new("z", nil))))
        add_item(list, 2, "O.o")
        assert_equal "z", list.head.link.link.link.data
      end
      it 'doesn\'t change the intermediate nodes' do
        list = LinkedList.new(Node.new("x", Node.new("y", Node.new("z", nil))))
        add_item(list, 2, "O.o")
        assert_equal "x", list.head.data
        assert_equal "y", list.head.link.data
      end
      it 'returns the list' do
        list = LinkedList.new(Node.new("x", Node.new("y", Node.new("z", nil))))
        assert_equal list, add_item(list, 2, "O.o")
      end
    end

    context 'when told to insert at a position other than 0, and there are not enough nodes there' do
      it 'creates a head node if one does not exist' do
        list = LinkedList.new
        add_item(list, 2, "O.o")
        assert_equal Node, list.head.class
      end
      it 'creates all the intermediate nodes up to that position' do
        list = LinkedList.new
        add_item(list, 2, "O.o")
        assert_equal Node, list.head.class
        assert_equal Node, list.head.link.class
      end
      it 'sets all intermediate node\'s data to nil' do
        list = LinkedList.new
        add_item(list, 2, "O.o")
        assert_equal nil, list.head.data
        assert_equal nil, list.head.link.data
      end
      it 'sets the last intermediate node\'s link to be the new node' do
        list = LinkedList.new
        add_item(list, 2, "O.o")
        assert_equal Node, list.head.link.link.class
      end
      it 'sets the new node\'s data to the inserted data' do
        list = LinkedList.new
        add_item(list, 2, "O.o")
        assert_equal "O.o", list.head.link.link.data
      end
      it 'sets the new node\'s link to be nil' do
        list = LinkedList.new
        add_item(list, 2, "O.o")
        assert_equal nil, list.head.link.link.link
      end
      it 'adds to the end of the last node, when nodes do exist' do
        list = LinkedList.new(Node.new("x", Node.new("y", Node.new("z", nil))))
        add_item(list, 5, "N")
        assert_equal "x", list.head.data
        assert_equal "y", list.head.link.data
        assert_equal "z", list.head.link.link.data
        assert_equal nil, list.head.link.link.link.data
        assert_equal nil, list.head.link.link.link.link.data
        assert_equal "N", list.head.link.link.link.link.link.data
        assert_equal nil, list.head.link.link.link.link.link.link
      end
      it 'returns the list' do
        list = LinkedList.new
        assert_equal list, add_item(list, 2, "O.o")
      end
    end
  end
end

__END__
  def test_given_a_linked_list_of_strings_return_a_linked_list_of_the_strings_with_more_than_5_chars
    skip
    # make sure it works when empty
    list     = LinkedList.new
    expected = LinkedList.new
    assert_equal expected, select_more_than_five_chars(list)

    # five is not selected
    list     = LinkedList.new(Node.new('abcde', nil))
    expected = LinkedList.new
    assert_equal expected, select_more_than_five_chars(list)

    # six is selected
    list     = LinkedList.new(Node.new('abcdef', nil))
    expected = LinkedList.new(Node.new('abcdef', nil))
    assert_equal expected, select_more_than_five_chars(list)

    # seven is selected
    list     = LinkedList.new(Node.new('abcdefg', nil))
    expected = LinkedList.new(Node.new('abcdefg', nil))
    assert_equal expected, select_more_than_five_chars(list)

    # multiple examples from a list
    list     = LinkedList.new(Node.new('', Node.new('123456', Node.new('abcdefghi', Node.new('lll', nil)))))
    expected = LinkedList.new(Node.new('123456', Node.new('abcdefghi', nil)))
    assert_equal expected, select_more_than_five_chars(list)
  end


  def test_given_a_linked_list_of_numbers_return_a_linked_list_of_just_the_even_numbers
    skip
    list     = LinkedList.new
    expected = LinkedList.new
    assert_equal expected, select_even(list)

    list     = LinkedList.new(Node.new(1, nil))
    expected = LinkedList.new
    assert_equal expected, select_even(list)

    list     = LinkedList.new(Node.new(1, Node.new(2, nil)))
    expected = LinkedList.new(Node.new(2, nil))
    assert_equal expected, select_even(list)

    list     = LinkedList.new(Node.new(1, Node.new(2, Node.new(3, Node.new(200, nil)))))
    expected = LinkedList.new(Node.new(2, Node.new(200, nil)))
    assert_equal expected, select_even(list)
  end


  def test_given_a_linked_list_of_strings_return_a_linked_list_of_the_strings_with_more_than_10_chars
    skip
    # make sure it works when empty
    list     = LinkedList.new
    expected = LinkedList.new
    assert_equal expected, select_more_than_ten_chars(list)

    # ten is not selected
    list     = LinkedList.new(Node.new('abcdefghij', nil))
    expected = LinkedList.new
    assert_equal expected, select_more_than_ten_chars(list)

    # eleven is selected
    list     = LinkedList.new(Node.new('abcdefghijk', nil))
    expected = LinkedList.new(Node.new('abcdefghijk', nil))
    assert_equal expected, select_more_than_ten_chars(list)

    # twelve is selected
    list     = LinkedList.new(Node.new('abcdefghijkl', nil))
    expected = LinkedList.new(Node.new('abcdefghijkl', nil))
    assert_equal expected, select_more_than_ten_chars(list)

    # multiple examples from a list
    list     = LinkedList.new(
                 Node.new('oooiiiuuukkk',
                 Node.new('123456',
                 Node.new('aaaaaaaaaaaaaaaaaa',
                 Node.new('0000000000000000000',
                 nil)))))
    expected = LinkedList.new(
                 Node.new('oooiiiuuukkk',
                 Node.new('aaaaaaaaaaaaaaaaaa',
                 Node.new('0000000000000000000',
                 nil))))
    assert_equal expected, select_more_than_ten_chars(list)
  end


  # Given a linked list of numbers, return a linked list of just the odd numbers
  # Given a linked list of numbers, return a linked list of just the numbers that pass a block I give you
  # Given a linked list of ints, return a linked list of the integers that are divisible by 3
  # Given a linked list of strings, return the count of how many end in an "s"
  # Given a linked list of strings, return a linked list of the ones that look like phone numbers (three digits, a dash, four digits)
  # In a linked list of medusas, find the medusa with the most statues
  # In a linked list of medusas, find all the medusas with more than 3 statues
  # In a linked list of medusas, Find all the statues in a linked list of medusas
  # In a linked list of medusas, find the medusa with the statue who has the the largest name
  # In a linked list of medusas, find all the statues whose last name is Smith
  # In a linked list of medusas, find all the statues in a linked list of medusas, but don't include statues that have the same name
  # In a linked list of medusas, find all the statues whose last name begins with an S
  # Find the first item from each list of a linked list of linked lists
  # Find the last item from each list of a linked list of linked lists
  # Given a linked list of strings, return a linked list of ints (ie map to_i)
  # Given a linked list of ints, return a linked list of strings (ie map to_s)
  # Flatten a linked list of linked lists
  # In a linked list of friend pairs, find the person with the most friends
  # Map a linked list of lists to the length of each list (ie map(&:count))
  # Given a linked list of linked lists of strings, return the list that has the largest number of strings that contain a smiley face
  # In a linked list of booleans, return the number they would represent if they represented binary 1s/0s
  # In a linked list of filenames, return the name of the file that has the most lines
  # Given a linked list of numbers, remove and return the element that has the fewest items
  # Do the above until the list is empty
  # Do the above, but return the result in a linked list (You just wrote a selection sort ;)
  # Given a linked list of medusas whose statues are trick or treaters with bags of candy, return how much candy each medusa has
  # Given a linked list of gems, return the one that is at the highest version
  # Obj model
  # * Given a binding, return its self
end


  # describe 'remove_item' do
  #   it 'removes the item at the first position when given 0'
  #     list = LinkedList.new(Node.new("a", nil))
  #     assert_equal "a", remove_item(list, 0)
  #     assert_equal nil, get_item(list, 0)

  #   it 'returns nil when there is no item to remove'
  #     list = LinkedList.new(Node.new("a", Node.new("b", nil)))
  #     assert_equal 'a', remove_item(list, 0)
  #     assert_equal 'b', get_item(list, 0)
  #     assert_equal nil, get_item(list, 1)

  #   it 'returns nil when there is no item to remove'
  #     list = LinkedList.new(Node.new("a", Node.new("b", nil)))
  #     assert_equal 'b', remove_item(list, 1)
  #     assert_equal 'a', get_item(list, 0)
  #     assert_equal nil, get_item(list, 1)

  #     list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
  #     assert_equal 'b', remove_item(list, 1)
  #     assert_equal 'a', get_item(list, 0)
  #     assert_equal 'c', get_item(list, 1)
  #     assert_equal nil, get_item(list, 2)
  #     assert_equal 'c', remove_item(list, 1)
  #     assert_equal 'a', get_item(list, 0)
  #     assert_equal nil, get_item(list, 1)
  #     assert_equal 'a', remove_item(list, 0)
  #     assert_equal nil, get_item(list, 0)
  #     assert_equal nil, get_item(list, 1)
