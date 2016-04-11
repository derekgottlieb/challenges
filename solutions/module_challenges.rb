module MahMixin
  module Equality
    def <(other)
      compared = self <=> other
      return compared < 0 if compared
      raise ArgumentError, "comparison of #{self.class} with #{other.class} failed"
    end

    def <=(other)
      compared = self <=> other
      return compared <= 0 if compared
      raise ArgumentError, "comparison of #{self.class} with #{other.class} failed"
    end

    def >(other)
      compared = self <=> other
      return compared > 0 if compared
      raise ArgumentError, "comparison of #{self.class} with #{other.class} failed"
    end

    def >=(other)
      compared = self <=> other
      return 0 <= compared if compared
      raise ArgumentError, "comparison of #{self.class} with #{other.class} failed"
    end

    def ==(other)
      0 == (self <=> other)
    end

    def between?(lower_bound, upper_bound)
      self >= lower_bound && self <= upper_bound
    end
  end


  class User
    include Equality

    attr_reader :name, :age

    def initialize(name, age)
      @name, @age = name, age
    end

    def <=>(user)
      return nil unless user.kind_of? self.class
      age_comparison = (age <=> user.age)
      return age_comparison unless 0 == age_comparison
      name.downcase <=> user.name.downcase
    end
  end
end


module MahMod
  module A
    C = 1
  end

  module B
    C = 2
  end

  def self.find_c(mod)
    mod::C
  end

  def self.make_mod(arg)
    mod = Module.new
    mod.const_set(:ARG, arg)
    mod
  end

  String = ::String
  Dir = "These aren't the Dirs you're looking for"

  def self.mah_dir
    Dir
  end
  def self.top_dir
    ::Dir
  end

  class List
    attr_reader :head
    def unshift(data)
      old_head = @head
      @head = Module.new do
        const_set :LINK, old_head
        const_set :DATA, data
      end
    end
  end
end
