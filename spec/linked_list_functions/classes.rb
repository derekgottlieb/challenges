# I'm putting these at the toplevel to make it easier for you,
# but it's best to avoid this as it pollutes Object's constants.
class LinkedList
  attr_accessor :head
  def initialize(head=nil)
    @head = head
  end

  def ==(other)
    other.kind_of?(LinkedList) && self.head == other.head
  end
end

class Node
  attr_accessor :data, :link
  def initialize(data, link)
    @data, @link = data, link
  end

  def ==(other)
    other.kind_of?(Node) && self.data == other.data && self.link == other.link
  end
end
