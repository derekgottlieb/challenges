require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
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
end
