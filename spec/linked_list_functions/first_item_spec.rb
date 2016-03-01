RSpec.describe 'linked list functions' do
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
end
