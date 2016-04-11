# tests are in spec/module_challenges
# Here is a video of me writing this for arrays instead of lists https://vimeo.com/133626457

module Iterable
  def to_a
    array = []
    each { |e| array << e }
    array
  end

  def find(&block)
    each { |e| return e if block.call e }
    nil
  end

  def find_all(&block)
    found = Ooll.new
    each { |e| found << e if block.call e }
    found
  end

  def map(&block)
    mapped = Ooll.new
    each { |e| mapped << block.call(e) }
    mapped
  end

  def all?(&block)
    each { |e| return false unless block.call e }
    true
  end

  def any?(&block)
    each { |e| return true if block.call e }
    false
  end

  def none?(&block)
    each { |e| return false if block.call e }
    true
  end

  def include?(needle)
    each { |hay| return true if needle == hay }
    false
  end

  def each_with_object(object, &block)
    each { |e| block.call e, object }
    object
  end

  def take(n)
    taken = Ooll.new
    each do |e|
      break if n == 0
      taken << e
      n -= 1
    end
    taken
  end

  def drop(n)
    taken = Ooll.new
    each do |e|
      if n == 0
        taken << e
      else
        n -= 1
      end
    end
    taken
  end

  def count(&block)
    block ||= Proc.new { true }
    count = 0
    each { |e| count += 1 if block.call e }
    count
  end

  def inject(initial, symbol=nil, &block)
    block = symbol.to_proc if symbol
    each { |e| initial = block.call initial, e }
    initial
  end

  def first(n=nil)
    return take(n) if n
    each { |e| return e }
    nil
  end

  def each_with_index(&block)
    index = 0
    each do |element|
      block.call element, index
      index += 1
    end
    self
  end

  def min_by(&block)
    min_val = nil
    min_cmp = nil
    i       = 0
    each do |e|
      cmp = block.call(e)
      if i == 0
        min_val = e
        min_cmp = cmp
      elsif cmp < min_cmp
        min_val = e
        min_cmp = cmp
      end
      i += 1
    end
    min_val
  end

  def max_by(&block)
    max_val = nil
    max_cmp = nil
    i       = 0
    each do |e|
      cmp = block.call(e)
      if i == 0
        max_val = e
        max_cmp = cmp
      elsif cmp > max_cmp
        max_val = e
        max_cmp = cmp
      end
      i += 1
    end
    max_val
  end
end
