def block_to_proc(&block)
  block
end

def wrap(value)
  lambda { value }
end

def call_twice(&block)
  block.call
  block.call
end

def call_thrice(&block)
  block.call
  block.call
  block.call
end

def yield_first(array, &block)
  block.call array[0] unless array.empty?
end

def yield_em_all(array, &block)
  array.each &block
end

def yield_two(array, &block)
  block.call(array[0])
  block.call(array[1])
end

alias yield_three yield_em_all
alias yield_four  yield_em_all
alias yield_five  yield_em_all
alias yield_six   yield_em_all
alias yield_seven yield_em_all
alias yield_eight yield_em_all
alias yield_nine  yield_em_all
alias yield_ten   yield_em_all

def yield_with_while_loop(array, &block)
  i = 0
  while i < array.length
    block.call array[i]
    i += 1
  end
end

def yield_with_each(array, &block)
  array.each &block
end

def best_advice(array, &block)
  array.find &block
end

def blinked_list_unshift(link, data)
  block_to_proc do |request|
    if request == :data
      data
    elsif request == :link
      link
    else
      raise ArgumentError, "expected :data or :link, got #{request.inspect}"
    end
  end
end

class Object
  def aside(&block)
    unless block
      raise LocalJumpError, "no block given"
    end
    block.call self
    self
  end
end

class PubSubSimple
  def subscribe(&block)
    raise LocalJumpError, 'no block given' unless block
    @subscriber = block
  end

  def publish(notification=nil)
    @subscriber && @subscriber.call(notification)
  end
end

class OnCount
  attr_reader :count
  def initialize(count=0, &block)
    @callback = block
    @count = count
    @on = true
  end

  def off
    @on = false
    self
  end

  def on
    @on = true
    self
  end

  def on?
    @on
  end

  def off?
    !on?
  end

  def count!
    @count += 1
    @callback.call count if @callback
    self
  end
end

class PubSub
  def initialize
    @subscriptions = {}
  end

  def subscribe(type, &block)
    raise LocalJumpError, 'no block given' unless block
    subscriptions_for(type) << block
  end

  def publish(type, value=nil)
    subscriptions_for(type).each { |subscriber| subscriber.call value }
  end
  private

  def subscriptions_for(type)
    @subscriptions[type] ||= []
  end
end

class Do
  def initialize(&block)
    @block = block
  end

  def if(val)
    @block.call if val
  end

  def unless(val)
    @block.call unless val
  end

  def while(&condition)
    @block.call while condition.call
  end

  def until(&condition)
    @block.call until condition.call
  end
end


def block_and_forth(&block)
  block.call { |n| n * 2 }
end

def block_and_forth_forever(&block)
  forever = block_to_proc { |&block| block.call &forever }
  forever.call(&block)
end
