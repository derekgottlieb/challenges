require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
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
end
