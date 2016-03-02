require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'list_min' do
    it 'returns nil for the empty list' do
      list = LinkedList.new
      assert_equal nil, list_min(list)
    end

    it 'returns the first item when there is only one' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal "a", list_min(list)
    end

    describe 'returns the item that is less than the others, when there is more than one' do
      example '("a" -> "b" -> "c") returns "a"' do
        list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
        assert_equal "a", list_min(list)
      end

      example '("a" -> "c" -> "b") returns "a"' do
        list = LinkedList.new Node.new("a", Node.new("c", Node.new("b", nil)))
        assert_equal "a", list_min(list)
      end

      example '("b" -> "a" -> "c") returns "a"' do
        list = LinkedList.new Node.new("b", Node.new("a", Node.new("c", nil)))
        assert_equal "a", list_min(list)
      end

      example '("b" -> "c" -> "a") returns "a"' do
        list = LinkedList.new Node.new("b", Node.new("c", Node.new("a", nil)))
        assert_equal "a", list_min(list)
      end

      example '("c" -> "b" -> "a") returns "a"' do
        list = LinkedList.new Node.new("c", Node.new("b", Node.new("a", nil)))
        assert_equal "a", list_min(list)
      end

      example '("c" -> "a" -> "b") returns "a"' do
        list = LinkedList.new Node.new("c", Node.new("a", Node.new("b", nil)))
        assert_equal "a", list_min(list)
      end

      example '(100 -> 45 -> 300)  returns 45' do
        list = LinkedList.new Node.new(100, Node.new(45, Node.new(300, nil)))
        assert_equal 45, list_min(list)
      end

      example 'A larger example' do
        list = LinkedList.new Node.new(100, Node.new(45, Node.new(300, Node.new(742, Node.new(15, nil)))))
        assert_equal 15, list_min(list)
      end
    end
  end
end

