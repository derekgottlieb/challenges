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


def get_item(list, index)
  return nil unless list.head
  node = list.head
  while node && index > 0
    node = node.link
    index -= 1
  end
  node && node.data
end


def shift_item(list)
  return nil unless list.head
  data = list.head.data
  list.head = list.head.link
  data
end


def remove_item(list, index)
  return nil unless list.head

  if list.head && index == 0
    data = list.head.data
    list.head = list.head.link
    return data
  end

  node = list.head
  while node.link && index > 1
    node = node.link
    index -= 1
  end

  to_remove = node.link
  node.link = node.link.link if node && node.link
  to_remove && to_remove.data
end


def unshift_list(list, data)
  list.head = Node.new(data, list.head)
  list
end


def add_item(list, index, data)
  if index == 0
    list.head = Node.new(data, list.head)
    return list
  end

  node = list.head
  while node.link && 1 < index
    node = node.link
    index -= 1
  end

  while 1 < index
    node.link = Node.new(nil, nil)
    node = node.link
    index -= 1
  end

  node.link = Node.new(data, node.link)

  list
end


def select_more_than_five_chars(list)
  new_list = LinkedList.new
  node = list.head
  while node
    if node.data.length > 5
      add_item new_list, list_size(new_list), node.data
    end
    node = node.link
  end
  new_list
end

def select_more_than_ten_chars(list)
  new_list = LinkedList.new
  node = list.head
  while node
    if node.data.length > 10
      add_item new_list, list_size(new_list), node.data
    end
    node = node.link
  end
  new_list
end



def select_even(list)
  new_list = LinkedList.new
  node = list.head
  while node
    if node.data.even?
      add_item new_list, list_size(new_list), node.data
    end
    node = node.link
  end
  new_list
end

