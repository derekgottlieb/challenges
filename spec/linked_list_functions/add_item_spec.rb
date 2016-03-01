require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
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
