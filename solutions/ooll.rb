# tests are in spec/module_challenges

require 'iterable'

class Ooll
  class Node
    attr_accessor :data, :link
    def initialize(data, link)
      @data, @link = data, link
    end
  end

  include Iterable

  def self.[](*elements)
    list = new
    elements.reverse_each do |item|
      list.unshift item
    end
    list
  end

  def [](index)
    return nil unless @head
    node = @head
    while node && 0 < index
      index -= 1
      node = node.link
    end
    node && node.data
  end

  def unshift(data)
    @head = Node.new(data, @head)
    self
  end

  def shift
    return nil unless @head
    data, @head = @head.data, @head.link
    data
  end

  def <<(data)
    return unshift data unless @head
    node = @head
    node = node.link while node.link
    node.link = Node.new(data, nil)
    self
  end

  def pop
    if !@head
      data = nil
    elsif !@head.link
      data = @head.data
      @head = nil
    else
      node = @head
      node = node.link while node.link.link
      data = node.link.data
      node.link = nil
    end
    data
  end

  def ==(other)
    return false unless other.kind_of? self.class
    node1 = self.head
    node2 = other.head
    loop do
      return true  if node1.nil? && node2.nil?
      return false if node1.nil? || node2.nil?
      return false if node1.data != node2.data
      node1, node2 = node1.link, node2.link
    end
  end

  def join(delimiter="")
    delimiter = "" if delimiter == nil
    joined    = ""
    node      = @head
    while node
      joined += node.data.to_s
      joined += delimiter
      node    = node.link
    end
    joined.chomp delimiter
  end

  def each(&block)
    node = @head
    while node
      block.call node.data
      node = node.link
    end
    self
  end

  protected def head
    @head
  end
end
