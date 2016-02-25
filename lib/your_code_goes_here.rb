def first_item(list)
  list.head && list.head.data
end

def last_item(list)
  node = list.head
  node = node.link while node && node.link
  node && node.data
end

def smallest_item(list)
  return nil unless list.head
  node     = list.head
  smallest = node.data
  while node
    smallest = node.data if node.data < smallest
    node = node.link
  end
  smallest
end


def largest_item(list)
  return nil unless list.head
  node     = list.head
  largest = node.data
  while node
    largest = node.data if node.data > largest
    node = node.link
  end
  largest
end


def list_size(list)
  size = 0
  node = list.head
  while node
    size += 1
    node = node.link
  end
  size
end
