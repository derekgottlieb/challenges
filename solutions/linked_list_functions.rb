# A function is a method that doesn't use any instance variables
# So it only works with its arguments, as local variables


# These ones are good to start with:
def list_first(list)
  list.head.data if list.head
end

def list_shift(list)
  data = list_first(list)
  list.head = list.head.link if list.head
  data
end

def list_unshift(list, data)
  list.head = Node.new(data, list.head)
  list
end

# Probably a nice intermediate set

def list_each_node(list, &block)
  node = list.head
  while node
    block.call node
    node = node.link
  end
end

def list_size(list)
  size = 0
  list_each_node(list) { size += 1 }
  size
end

def list_last(list)
  last = nil
  list_each_node(list) { |node| last = node.data }
  last
end

def list_min(list)
  min = list_first(list)
  list_each_node(list) { |node| min = node.data if node.data < min }
  min
end

def list_max(list)
  max = list_first(list)
  list_each_node(list) { |node| max = node.data if max < node.data }
  max
end


# These ones are harder
def list_at(list, index)
  crnt = 0
  list_each_node list do |node|
    return node.data if index == crnt
    crnt += 1
  end
  nil
end

def list_join(list, delimiter="")
  joined = ""
  list_each_node list do |node|
    joined << node.data.to_s
    joined << delimiter
  end
  joined.chomp(delimiter)
end

def list_insert(list, index, data)
  list.head = node_insert(list.head, index, data)
  list
end

def node_insert(node, index, data)
  return Node.new(data, node) if index == 0
  return Node.new node.data, node_insert(node.link, index-1, data) if node
  Node.new nil, node_insert(node, index-1, data)
end
