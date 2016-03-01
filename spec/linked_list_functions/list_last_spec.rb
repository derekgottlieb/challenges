require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'list_last' do
    it 'returns nil for an empty list' do
      list = LinkedList.new()
      assert_equal nil, list_last(list)
    end

    it 'returns the first item when there is only one' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", list_last(list)
    end

    it 'returns the last item when there is more than one' do
      list = LinkedList.new(Node.new(:lol, Node.new(:wtf, Node.new(:bbq, nil))))
      assert_equal :bbq, list_last(list)
    end
  end
end

