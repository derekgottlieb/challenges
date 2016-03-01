RSpec.describe 'linked list functions' do
  describe 'list_first' do
    it 'returns nil for an empty list' do
      list = LinkedList.new()
      assert_equal nil, list_first(list)
    end

    it 'returns the data of the first item, when there is one item' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", list_first(list)
    end


    it 'returns the data of the first item, when there is more than one item' do
      list = LinkedList.new(Node.new(:lol, Node.new(:wtf, Node.new(:bbq, nil))))
      assert_equal :lol, list_first(list)
    end
  end
end
