require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'list_unshift' do
    it 'inserts an item at the head of the list' do
      list = LinkedList.new

      list_unshift(list, "b")
      expected = LinkedList.new(Node.new("b", nil))
      assert_equal expected, list

      list_unshift(list, 1)
      expected = LinkedList.new(Node.new(1, Node.new("b", nil)))
      assert_equal expected, list
    end

    it 'returns the list itself' do
      list = LinkedList.new
      assert_equal list, list_unshift(list, "b")
    end
  end
end
