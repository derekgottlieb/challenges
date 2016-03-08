require 'list_recursion'
require 'spec_helper'

RSpec.describe 'list recursion' do
  # This gives the tests a method named `nil_node`,
  # whose value is what's in the block.
  # It is different from normal methods in that
  # it only runs the code the first time,
  # so that successive invocations of `nil_node` from within a test
  # will return the same node (this resets for each test).
  let(:nil_node) { NilNode.new }

  describe 'NilNode' do
    it 'always has data of nil' do
      assert_equal nil, nil_node.data
    end
    it 'does not have a data=' do
      # respond_to? is inherited, you don't have to make it
      assert_equal false, nil_node.respond_to?(:data=)
    end
    it 'links to itself' do
      assert_equal nil_node, nil_node.link
    end
    it 'does not have a link=' do
      assert_equal false, nil_node.respond_to?(:link=)
    end
    it 'has a length of 0' do
      assert_equal 0, nil_node.length
    end
    it 'has a min of nil' do
      assert_equal nil, nil_node.min
    end
    it 'has a max of nil' do
      assert_equal nil, nil_node.max
    end
    specify '#first returns nil' do
      assert_equal nil, nil_node.first
    end
    specify '#last returns nil' do
      assert_equal nil, nil_node.last
    end
    it 'is empty' do
      assert_equal true, nil_node.empty?
    end
    it 'returns true when asked if it is nil?' do
      assert_equal true, nil_node.nil?
    end
    describe '#[] returns nil' do
      example('at 0')   { assert_equal nil, nil_node[0] }
      example('at 1')   { assert_equal nil, nil_node[1] }
      example('at 100') { assert_equal nil, nil_node[100] }
    end
    describe 'insertion' do
      context 'at 0' do
        it 'returns a normal node' do
          assert_equal NormalNode, nil_node.insert(0, 'abc').class
        end
        specify 'with the inserted data' do
          assert_equal 'abc', nil_node.insert(0, 'abc').data
        end
        specify 'whose link is a nilnode' do
          assert_equal nil_node, nil_node.insert(0, 'abc').link
        end
      end
      context 'at 1' do
        it 'returns a normal node' do
          assert_equal NormalNode, nil_node.insert(1, 'abc').class
        end
        specify 'with data of nil' do
          assert_equal nil, nil_node.insert(1, 'abc').data
        end
        specify 'whose link is the same as inserting at 0' do
          link = nil_node.insert(1, 'abc').link
          assert_equal NormalNode, link.class
          assert_equal 'abc'     , link.data
          assert_equal nil_node  , link.link
        end
      end
      context 'at 3' do
        it 'returns a normal node' do
          assert_equal NormalNode, nil_node.insert(3, 'O.o').class
        end
        specify 'with data of nil' do
          assert_equal nil, nil_node.insert(3, 'O.o').data
        end
        specify 'whose link is the same as inserting at 2' do
          result = nil_node.insert(3, 'O.o')
          assert_equal nil   , result.data
          assert_equal nil   , result.link.data
          assert_equal nil   , result.link.link.data
          assert_equal 'O.o' , result.link.link.link.data
        end
      end
    end
  end

  describe 'NormalNode' do
    let(:node_b)  { NormalNode.new('b', nil_node) }
    let(:node_ab) { NormalNode.new('a', node_b) }
    let(:node_cb) { NormalNode.new('c', node_b) }

    it 'has data of whatever it was initialized with' do
      assert_equal 'b', node_b.data
      assert_equal 'a', node_ab.data
      assert_equal 'c', node_cb.data
    end
    it 'does not have a data=' do
      assert_equal false, node_b.respond_to?(:data=)
    end
    it 'has a link is whatever it was initialized with' do
      assert_equal node_b, node_ab.link
      assert_equal nil_node, node_ab.link.link
    end
    it 'does not have a link=' do
      assert_equal false, node_ab.respond_to?(:link=)
    end
    describe 'has a length of 1 more than its link\'s length' do
      example 'one deep' do
        assert_equal 1, node_b.length
      end
      example 'two deep' do
        assert_equal 2, node_ab.length
      end
    end
    describe 'min' do
      it 'returns its data when its link is a NilNode' do
        assert_equal 'b', node_b.min
      end
      it 'returns its data when its data is less than its links data' do
        assert_equal 'a', node_ab.min
      end
      it 'returns its links data when its links data is less than its data' do
        assert_equal 'b', node_cb.min
      end
      it 'does not depend on its link\'s data for verifying correctness' do
        node = NormalNode.new('a', NormalNode.new(nil, nil_node))
        expect { node.min }.to raise_error ArgumentError, /nil/
      end
    end
    describe 'max' do
      it 'returns its data when its link is a NilNode' do
        assert_equal 'b', node_b.max
      end
      it 'returns its data when its data is greater than its links data' do
        assert_equal 'b', node_ab.max
      end
      it 'returns its links data when its links data is greater than its data' do
        assert_equal 'c', node_cb.max
      end
      it 'does not depend on its link\'s data for verifying correctness' do
        node = NormalNode.new('a', NormalNode.new(nil, nil_node))
        expect { node.min }.to raise_error ArgumentError, /nil/
      end
    end
    specify '#first returns its data' do
      assert_equal 'b', node_b.first
      assert_equal 'a', node_ab.first
      assert_equal 'c', node_cb.first
    end
    describe '#last' do
      it 'returns its data when its link is a nil node' do
        assert_equal 'b', node_b.last
      end
      it 'returns its link\'s data when its link is not a nil node' do
        assert_equal 'b', node_ab.last
      end
      it 'even if its link\'s data is nil' do
        node = NormalNode.new('a', NormalNode.new(nil, nil_node))
        assert_equal nil, node.last
      end
    end
    describe '#empty?' do
      it('is not empty') { assert_equal false, node_b.empty? }
      specify 'even if its data is nil' do
        assert_equal false, NormalNode.new(nil, nil_node).empty?
      end
    end
    describe '#nil?' do
      it 'returns false when asked if it is nil?' do
        assert_equal false, node_b.nil?
      end
      specify 'even if its data is nil' do
        assert_equal false, NormalNode.new(nil, nil_node).nil?
      end
    end
    describe '#[]' do
      specify 'when asked for the data at index 0, it returns its own data' do
        assert_equal 'b', node_b[0]
        assert_equal 'a', node_ab[0]
        assert_equal 'c', node_cb[0]
      end
      specify 'otherwise it returns its link\'s result for one index lower' do
        assert_equal 'b', node_ab[1]
        assert_equal 'b', node_cb[1]
      end
      example 'a more challenging example' do
        node5 = NormalNode.new('p', nil_node)
        node4 = NormalNode.new('i', node5)
        node3 = NormalNode.new('h', node4)
        node2 = NormalNode.new('l', node3)
        node1 = NormalNode.new('k', node2)
        assert_equal 'k', node1[0]
        assert_equal 'l', node1[1]
        assert_equal 'h', node1[2]
        assert_equal 'i', node1[3]
        assert_equal 'p', node1[4]
        assert_equal nil, node1[5]

        assert_equal 'l', node2[0]
        assert_equal 'h', node2[1]
        assert_equal 'i', node2[2]
        assert_equal 'p', node2[3]
        assert_equal nil, node2[4]
      end
    end
    describe 'insertion' do
      context 'at index 0' do
        it 'returns a new normal node' do
          assert_equal NormalNode, node_ab.insert(0, 'x').class
        end
        specify 'the returned node has the data' do
          assert_equal 'x', node_ab.insert(0, 'x').data
        end
        specify 'and the returned node\'s link is the node we called insert on' do
          assert_equal node_ab, node_ab.insert(0, 'x').link
        end
        specify 'the node we called insert on is not modified' do
          node_ab.insert(0, 'x')
          assert_equal 'a',      node_ab.data
          assert_equal node_b,   node_ab.link
          assert_equal 'b',      node_b.data
          assert_equal nil_node, node_b.link
        end
      end
      context 'otherwise' do
        it 'returns a normal node' do
          assert_equal NormalNode, node_ab.insert(1, 'x').class
        end
        specify 'the returned node has the current node\'s data' do
          inserted = node_ab.insert(1, 'x')
          assert_equal 'a', inserted[0]
        end
        specify 'the returned node\'s link includes the inserted item at the correct position' do
          inserted = node_ab.insert(1, 'x')
          assert_equal 'a', inserted[0]
          assert_equal 'x', inserted[1]
          assert_equal 'b', inserted[2]
          assert_equal nil, inserted[3]
        end
        specify 'it does not modifty the node we called the insert on' do
          _inserted = node_ab.insert(1, 'x')
          assert_equal 'a', node_ab[0] # note we assert against ab, not the result
          assert_equal 'b', node_ab[1]
          assert_equal nil, node_ab[2]
        end
      end
    end
  end
end
