class NilNode
  attr_reader :data, :link
  def initialize
    @link = self
  end
  def length
    0
  end
  def min(predecessors_min=nil)
    predecessors_min
  end
  def max(predecessors_max=nil)
    predecessors_max
  end
  def first
    nil
  end
  def last(prev=nil)
    prev
  end
  def empty?
    true
  end
  def nil?
    true
  end
  def [](index)
    nil
  end
  def insert(index, data)
    if index == 0
      NormalNode.new(data, self)
    else
      NormalNode.new(self.data, link.insert(index-1, data))
    end
  end
end

class NormalNode
  attr_reader :data, :link
  def initialize(data, link)
    @data, @link = data, link
  end
  def length
    link.length + 1
  end
  def min(predecessors_min=nil)
    return link.min data unless predecessors_min && predecessors_min < data
    link.min predecessors_min
  end
  def max(predecessors_max=nil)
    return link.max data unless predecessors_max && predecessors_max > data
    link.max predecessors_max
  end
  def first
    data
  end
  def last(prev=nil)
    link.last data
  end
  def empty?
    false
  end
  def nil?
    false
  end
  def [](index)
    if index == 0
      data
    else
      link[index-1]
    end
  end
  def insert(index, data)
    if index == 0
      NormalNode.new(data, self)
    else
      NormalNode.new(self.data, link.insert(index-1, data))
    end
  end
end
