# A function is a method that doesn't use any instance variables
# So it only works with its arguments, as local variables


# $ mrspec spec/linked_list_functions/list_first_spec.rb
def list_first(list)
  list.head.data unless list.head.nil?
end

def list_shift(list)
  unless list.head.nil?
    node = list.head
    list.head = node.link
    node.data
  end
end

def list_unshift(list, data)
 n = Node.new(data, list.head)
 list.head = n
 list
end

# Probably a nice intermediate set

def list_size(list)
  return 0 if list.head.nil?
  1 + list_size(LinkedList.new(list.head.link))
end

def list_last(list)
  return nil if list.head.nil?
  return list.head.data if list.head.link.nil?
  list_last(LinkedList.new(list.head.link))
end

def list_min(list)
  return nil if list.head.nil?
  min = list_min(LinkedList.new(list.head.link))
  return list.head.data if min.nil?
  if list.head.data < min
    list.head.data
  else
    min
  end
end

def list_max(list)
  return nil if list.head.nil?
  max = list_max(LinkedList.new(list.head.link))
  return list.head.data if max.nil?
  if list.head.data > max
    list.head.data
  else
    max
  end
end

# These ones are harder
def list_at(list, index)
  return nil if list.head.nil?
  return list.head.data if index == 0
  list_at(LinkedList.new(list.head.link), index-1)
end

def list_values(list)
  return [] if list.head.nil?
  [list.head.data, list_values(LinkedList.new(list.head.link))].flatten.compact
end

def list_join(list, delimiter="")
  values = list_values(list)
  values.join(delimiter)
end

def list_insert(list, index, data)
  if index == 0
    list.head = Node.new(data, list.head)
    return list
  end

  if list.head.nil?
    list.head = Node.new(nil, list_insert(LinkedList.new, index-1, data).head)
  else
    list.head.link = list_insert(LinkedList.new(list.head.link), index-1, data).head
  end
  list
end
