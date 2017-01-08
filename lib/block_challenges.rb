# Solving these first two:
# https://vimeo.com/157505448
def block_to_proc(&block)
  Proc.new(&block)
end

def wrap(value)
  Proc.new { value }
end

def call_n(n, &block)
  n.times do
    block.call
  end
end

# Spec is named call_twice_and_thrice_spec.rb
def call_twice(&block)
  call_n(2, &block)
end

def call_thrice(&block)
  call_n(3, &block)
end

def yield_n(n, array, &block)
  n.times { |i| block.call(array[i]) } unless array.empty?
end

def yield_first(array, &block)
  yield_n(1, array, &block)
end

def yield_em_all(array, &block)
end


def yield_two(array, &block)
  yield_n(2, array, &block)
end

def yield_three(array, &block)
  yield_n(3, array, &block)
end

def yield_four(array, &block)
  yield_n(4, array, &block)
end

def yield_five(array, &block)
  yield_n(5, array, &block)
end

def yield_six(array, &block)
  yield_n(6, array, &block)
end

def yield_seven(array, &block)
  yield_n(7, array, &block)
end

def yield_eight(array, &block)
  yield_n(8, array, &block)
end

def yield_nine(array, &block)
  yield_n(9, array, &block)
end

def yield_ten(array, &block)
  yield_n(10, array, &block)
end

# This receives a PrimitiveArray, which is a class I made that only
# has brackets and length, so you'll have to solve it the way you
# would in a language like C, which doesn't have real arrays
def yield_with_while_loop(array, &block)
  i = 0
  while i < array.length
    yield array[i]
    i += 1
  end
end

# This receives an ArrayWithOnlyEach, which, you may have guessed,
# only has the each method. Your solution will have to work in terms
# of each :)
def yield_with_each(array, &block)
  array.each { |i| yield i }
end

def best_advice(array, &block)
  array.each do |i|
    return i if (yield i) == true
  end
  nil
end

def blinked_list_unshift(link, data)
  Proc.new do |i|
    if i == :data
      data
    elsif i == :link
      link
    else
      raise ArgumentError, "expected :data or :link, got #{i.inspect}"
    end
  end
end

# You'll have to figure out how to define aside :)
class Object
  def aside(&block)
    raise LocalJumpError, "no block given" unless block_given?

    yield self
    return self
  end
end

# If you struggle with any of these, skip to the next one and come back later
class PubSubSimple
  # you'll have to figure out what goes in here :)
  def subscribe(&block)
    raise LocalJumpError, "no block given" unless block_given?
    @method = block
  end

  def publish(data = nil)
    @method.call(data) unless @method.nil?
  end
end

class OnCount
  def initialize(number = 0, &block)
    @number = number
    @on_state = true
    @block = block if block_given?
  end

  def count
    @number
  end

  def count!
    @number += 1 
    @block.call(@number) unless @block.nil?
    self
  end

  def on
    @on_state = true
    self
  end

  def on?
    @on_state
  end

  def off
    @on_state = false
    self
  end

  def off?
    !@on_state
  end
end

class PubSub
  def initialize
    @event_subscriptions = {}
  end

  def subscribe(event, &block)
    raise LocalJumpError, "no block given" unless block_given?
    @event_subscriptions[event] ||= []
    @event_subscriptions[event] << block
  end

  def publish(event, data = nil)
    @event_subscriptions[event] ||= []
    @event_subscriptions[event].map { |es| es.call(data) }
  end
end

class Do
  def initialize(&block)
    @block = block if block_given?
  end

  def if(truthy)
    @block.call() if truthy
  end

  def unless(falsey)
    @block.call() unless falsey
  end

  def while(&while_block)
    while while_block.call() do
      @block.call()
    end
  end

  def until(&until_block)
    while !(until_block.call()) do
      @block.call()
    end
  end
end

def block_and_forth(&block)
end

# this one is pretty similar to block_and_forth, but will require a local variable,
# and passing of a Proc into the block spot (if you don't know how to do this,
# go play with synseer until you see something that probably does it :)
# http://synseer.herokuapp.com/
def block_and_forth_forever(&block)
end
