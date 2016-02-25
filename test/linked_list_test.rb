require 'your_code_goes_here'

# I'm putting these at the toplevel to make it easier for you,
# but it's best to avoid this as it pollutes Object's constants.
class LinkedList
  attr_reader :head
  def initialize(head=nil)
    @head = head
  end
end

class Node
  attr_reader :data, :link
  def initialize(data, link)
    @data, @link = data, link
  end
end


class Medusa
  attr_reader :name, :statues
  def initialize(name, statues)
    @name, @statues = name, statues
  end
end


class Person
  attr_reader :name
  def initialize(name)
    @name = name
  end
end



class LinkedListTest < Minitest::Test
  def test_find_the_first_item_in_a_linked_list
    list = LinkedList.new()
    assert_equal nil, first_item(list)

    list = LinkedList.new
    assert_equal nil, first_item(list)

    list = LinkedList.new(Node.new("a", nil))
    assert_equal "a", first_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", nil)))
    assert_equal "a", first_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
    assert_equal "a", first_item(list)
  end


  def test_find_the_last_item_in_a_linked_list
    list = LinkedList.new()
    assert_equal nil, last_item(list)

    list = LinkedList.new
    assert_equal nil, last_item(list)

    list = LinkedList.new(Node.new("a", nil))
    assert_equal "a", last_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", nil)))
    assert_equal "b", last_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
    assert_equal "c", last_item(list)
  end


  def test_find_the_smallest_item_in_a_linked_list
    list = LinkedList.new
    assert_equal nil, smallest_item(list)

    list = LinkedList.new(Node.new("a", nil))
    assert_equal "a", smallest_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", nil)))
    assert_equal "a", smallest_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
    assert_equal "a", smallest_item(list)

    list = LinkedList.new(Node.new("c", Node.new("b", Node.new("a", nil))))
    assert_equal "a", smallest_item(list)
  end


  def test_find_the_largest_item_in_a_linked_list
    list = LinkedList.new
    assert_equal nil, largest_item(list)

    list = LinkedList.new(Node.new("a", nil))
    assert_equal "a", largest_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", nil)))
    assert_equal "b", largest_item(list)

    list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
    assert_equal "c", largest_item(list)

    list = LinkedList.new(Node.new("c", Node.new("b", Node.new("a", nil))))
    assert_equal "c", largest_item(list)
  end

  # Find the smallest item in a linked list (of size 0, 1, 2, 3)
  # Find the length of a linked list
  # Remove an item from a linked list
  # Add an item to a linked list
  # Given a linked list of numbers, return a linked list of just the even numbers
  # Given a linked list of numbers, return a linked list of just the odd numbers
  # Given a linked list of numbers, return a linked list of just the numbers that pass a block I give you
  # Given a linked list of strings, return a linked list of the strings with more than 5 chars
  # Given a linked list of strings, return a linked list of the strings with more than 10 chars
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

