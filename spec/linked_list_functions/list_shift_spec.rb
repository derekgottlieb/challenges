require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'list_shift' do
    it 'returns nil when the list is empty' do
      list = LinkedList.new
      assert_equal nil, list_shift(list)
      assert_equal LinkedList.new, list
    end

    it 'returns the first item when there is an element in the list' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", list_shift(list)
      assert_equal LinkedList.new, list
    end

    it 'removes the first item from the list' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", list_shift(list)
      assert_equal nil, list_shift(list)
    end

    example 'a bigger example' do
      list = LinkedList.new(Node.new(:abc, Node.new(:def, Node.new(:ghi, nil))))
      assert_equal :abc, list_shift(list)
      assert_equal LinkedList.new(Node.new(:def, Node.new(:ghi, nil))), list
      assert_equal :def, list_shift(list)
      assert_equal LinkedList.new(Node.new(:ghi, nil)), list
      assert_equal :ghi, list_shift(list)
      assert_equal LinkedList.new, list
      assert_equal nil,  list_shift(list)
    end
  end
end
