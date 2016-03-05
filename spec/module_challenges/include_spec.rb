require 'module_challenges/challenges'

module ClassesForIncludeSpec
  class AlwaysReturn
    def initialize(value)
      @value = value
    end

    def <=>(other)
      @value
    end
  end
end


module ClassesForIncludeSpec
  class NameOnly
    attr_reader :name, :space_ship_trips

    def initialize(name)
      @name = name
      @space_ship_trips = 0
    end

    def <=>(other)
      @space_ship_trips += 1
      name <=> other.name
    end
  end
end


RSpec.describe 'modules as "mixins"... aka using include to change inheritance' do
  def assert_raises(error_class, error_message=nil, &block)
    raised = false
    begin
      block.call
    rescue error_class => error
      raised = true
      error_message && assert_equal(error_message, error.message)
    end
    assert_equal true, raised
  end

  specify 'define a module named MahMixin' do
    assert_equal Module, MahMixin.class
  end

  describe 'MahMixin::Equality' do
    it 'is not available at the toplevel' do
      assert_raises NameError do
        Equality
      end
    end

    it 'is available from within MahMixin' do
      ClassesForIncludeSpec::AlwaysReturn.module_eval do
        include MahMixin::Equality # <-- THE INCLUSION HAPPENS HERE!
      end
      ClassesForIncludeSpec::NameOnly.module_eval do
        include MahMixin::Equality # <-- THE INCLUSION HAPPENS HERE!
      end
    end

    describe '`left < right` returns true when the left object is less than the right' do
      it 'returns false if the space ship operator returns zero' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(0)
        right  = :doesnt_matter
        result = left < right
        assert_equal false, result
      end
      it 'returns true if the space ship operator returns a negative value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(-1)
        right  = :doesnt_matter
        result = left < right
        assert_equal true, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(-100)
        right  = :doesnt_matter
        result = left < right
        assert_equal true, result
      end
      it 'returns false if the space ship operator returns a positive value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(1)
        right  = :doesnt_matter
        result = left < right
        assert_equal false, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(100)
        right  = :doesnt_matter
        result = left < right
        assert_equal false, result
      end
      it 'raises an ArgumentError with the compared class names, if the space ship returns nil' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(nil)
        right  = :doesnt_matter
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with Symbol failed' do
          left < right
        end
        right  = "doesn't matter"
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with String failed' do
          left < right
        end
      end
    end

    describe '`left <= right` returns true when the left object is less than or equal to the right' do
      it 'returns true if the space ship operator returns zero' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(0)
        right  = :doesnt_matter
        result = left <= right
        assert_equal true, result
      end
      it 'returns true if the space ship operator returns a negative value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(-1)
        right  = :doesnt_matter
        result = left <= right
        assert_equal true, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(-100)
        right  = :doesnt_matter
        result = left <= right
        assert_equal true, result
      end
      it 'returns false if the space ship operator returns a positive value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(1)
        right  = :doesnt_matter
        result = left <= right
        assert_equal false, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(100)
        right  = :doesnt_matter
        result = left <= right
        assert_equal false, result
      end
      it 'raises an ArgumentError if the space ship returns nil' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(nil)
        right  = :doesnt_matter
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with Symbol failed' do
          left <= right
        end
        right  = "doesn't matter"
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with String failed' do
          left < right
        end
      end
    end

    describe '`left > right` returns true when the left object is greater than' do
      it 'returns false if the space ship operator returns zero' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(0)
        right  = :doesnt_matter
        result = left > right
        assert_equal false, result
      end
      it 'returns true if the space ship operator returns a positive value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(1)
        right  = :doesnt_matter
        result = left > right
        assert_equal true, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(100)
        right  = :doesnt_matter
        result = left > right
        assert_equal true, result
      end
      it 'returns false if the space ship operator returns a negative value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(-1)
        right  = :doesnt_matter
        result = left > right
        assert_equal false, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(-100)
        right  = :doesnt_matter
        result = left > right
        assert_equal false, result
      end
      it 'raises an ArgumentError if the space ship returns nil' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(nil)
        right  = :doesnt_matter
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with Symbol failed' do
          left > right
        end
        right  = "doesn't matter"
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with String failed' do
          left < right
        end
      end
    end

    describe '`left >= right` returns true when the left object is greater than or equal to the right' do
      it 'returns true if the space ship operator returns zero' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(0)
        right  = :doesnt_matter
        result = left >= right
        assert_equal true, result
      end
      it 'returns true if the space ship operator returns a positive value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(1)
        right  = :doesnt_matter
        result = left >= right
        assert_equal true, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(100)
        right  = :doesnt_matter
        result = left >= right
        assert_equal true, result
      end
      it 'returns false if the space ship operator returns a negative value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(-1)
        right  = :doesnt_matter
        result = left >= right
        assert_equal false, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(-100)
        right  = :doesnt_matter
        result = left >= right
        assert_equal false, result
      end
      it 'raises an ArgumentError if the space ship returns nil' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(nil)
        right  = :doesnt_matter
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with Symbol failed' do
          left >= right
        end
        right  = "doesn't matter"
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::AlwaysReturn with String failed' do
          left < right
        end
      end
    end

    describe '`left == right` returns true when the left object is equal to' do
      it 'returns true if the space ship operator returns zero' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(0)
        right  = :doesnt_matter
        result = left == right
        assert_equal true, result
      end
      it 'returns false if the space ship operator returns a positive value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(1)
        right  = :doesnt_matter
        result = left == right
        assert_equal false, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(100)
        right  = :doesnt_matter
        result = left == right
        assert_equal false, result
      end
      it 'returns false if the space ship operator returns a negative value' do
        left   = ClassesForIncludeSpec::AlwaysReturn.new(-1)
        right  = :doesnt_matter
        result = left == right
        assert_equal false, result

        left   = ClassesForIncludeSpec::AlwaysReturn.new(-100)
        right  = :doesnt_matter
        result = left == right
        assert_equal false, result
      end
      it 'returns false if the space ship returns nil' do
        left = ClassesForIncludeSpec::AlwaysReturn.new(nil)
        assert_equal false, (left == :doesnt_matter)
        assert_equal false, (left == 'doesnt_matter')
      end
    end

    describe 'between?' do
      let(:aaa) { ClassesForIncludeSpec::NameOnly.new 'aaa' }
      let(:bbb) { ClassesForIncludeSpec::NameOnly.new 'bbb' }
      let(:ccc) { ClassesForIncludeSpec::NameOnly.new 'ccc' }
      let(:ddd) { ClassesForIncludeSpec::NameOnly.new 'ddd' }
      let(:eee) { ClassesForIncludeSpec::NameOnly.new 'eee' }
      let(:fff) { ClassesForIncludeSpec::NameOnly.new 'fff' }

      let(:ddd2) { ClassesForIncludeSpec::NameOnly.new 'ddd' }
      let(:ddd3) { ClassesForIncludeSpec::NameOnly.new 'ddd' }
      let(:nil_int) { ClassesForIncludeSpec::NameOnly.new 123 }

      it 'returns false when the object is less than the first arg' do
        assert_equal false, ddd.between?(eee, fff)
        assert_equal 0, eee.space_ship_trips
        assert_equal 0, fff.space_ship_trips
      end

      specify 'even if it is also greater than the second (makes no sense, I know)' do
        assert_equal false, ddd.between?(eee, ccc)
        assert_equal 0, eee.space_ship_trips
        assert_equal 0, ccc.space_ship_trips
      end

      it 'returns false when the object is greater than the second arg' do
        assert_equal false, ddd.between?(aaa, bbb)
        assert_equal 0, aaa.space_ship_trips
        assert_equal 0, bbb.space_ship_trips
      end

      specify 'even if it is also less than the first (makes no sense, I know)' do
        assert_equal false, ddd.between?(eee, ccc)
        assert_equal 0, eee.space_ship_trips
        assert_equal 0, ccc.space_ship_trips
      end

      it 'returns true when the object is greater than the first and less than the second' do
        assert_equal true, ddd.between?(ccc, eee)
        assert_equal 0, eee.space_ship_trips
        assert_equal 0, ccc.space_ship_trips
      end

      it 'returns true when the object is equal to the first and less than the second' do
        assert_equal true, ddd.between?(ddd2, eee)
        assert_equal 0, ddd2.space_ship_trips
        assert_equal 0, eee.space_ship_trips
      end

      it 'returns true when the object is greater than the first and equal to the second' do
        assert_equal true, ddd.between?(ccc, ddd2)
        assert_equal 0,    ccc.space_ship_trips
        assert_equal 0,    ddd2.space_ship_trips
      end

      it 'returns true when the object is equal to both' do
        assert_equal true, ddd.between?(ddd2, ddd3)
        assert_equal 0,    ddd2.space_ship_trips
        assert_equal 0,    ddd3.space_ship_trips
      end

      it 'returns false when the object is equal to the first and greater than the second' do
        assert_equal false, ddd.between?(ddd2, ccc)
        assert_equal 0,     ddd2.space_ship_trips
        assert_equal 0,     ccc.space_ship_trips
      end

      it 'returns false when the object is less than the first and equal to the second' do
        assert_equal false, ddd.between?(eee, ddd2)
        assert_equal 0,    eee.space_ship_trips
        assert_equal 0,    ddd2.space_ship_trips
      end

      it 'raises an ArgumentError if the space ship returns nil for the left argument' do
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::NameOnly with ClassesForIncludeSpec::NameOnly failed' do
          ddd.between? nil_int, eee
        end
      end

      it 'does not raise an error if it is ruled out by the first argument before it is compared to the second argument, even if the second argument would be nil' do
        assert_equal false, ddd.between?(eee, nil_int)
      end

      it 'raises an ArgumentError if the space ship returns nil for the right argument' do
        assert_raises ArgumentError, 'comparison of ClassesForIncludeSpec::NameOnly with ClassesForIncludeSpec::NameOnly failed' do
          assert_equal false, ddd.between?(aaa, nil_int)
        end
      end
    end

    describe 'defined methods' do
      it 'only defines the methods <, <=, >, >=, ==, and between?' do
        methods = MahMixin::Equality.instance_methods.sort
        assert_equal [:<, :<=, :==, :>, :>=, :between?], methods
      end
    end
  end

  describe 'MahMixin::User' do
    it 'is not available at the toplevel' do
      assert_raises(NameError) { User }
    end

    it 'is available from within MahMixin' do
      MahMixin::User
    end

    specify 'users have a name and age' do
      user = MahMixin::User.new 'Janet', 86
      assert_equal 'Janet', user.name
      assert_equal 86,      user.age
    end

    describe 'ordering users users' do
      it 'cannot be compared to a non-user' do
        user    = MahMixin::User.new 'Zanzder', 100
        message = 'comparison of MahMixin::User with String failed'
        assert_raises(ArgumentError, message) { user <  'a' }
        assert_raises(ArgumentError, message) { user <= 'b' }
        assert_raises(ArgumentError, message) { user >  'c' }
        assert_raises(ArgumentError, message) { user >= 'd' }
        user == 'e'
      end
      context 'when the left user is younger than the right user' do
        it 'is ordered earlier' do
          zander = MahMixin::User.new 'Zanzder', 100
          albert = MahMixin::User.new 'Albert',  101
          assert_equal true,  (zander <  albert)
          assert_equal true,  (zander <= albert)
          assert_equal false, (zander >  albert)
          assert_equal false, (zander >= albert)
          assert_equal false, (zander == albert)
        end
      end
      context 'when the left user is older than the right user' do
        it 'is ordered later' do
          zander = MahMixin::User.new 'Zanzder', 101
          albert = MahMixin::User.new 'Albert',  100
          assert_equal false, (zander <  albert)
          assert_equal false, (zander <= albert)
          assert_equal true,  (zander >  albert)
          assert_equal true,  (zander >= albert)
          assert_equal false, (zander == albert)
        end
      end
      context 'when the left user is the same age as the right user' do
        context 'when the left user\'s name is alphabetically earlier' do
          it 'is ordered earlier' do
            zander = MahMixin::User.new 'Zanzder', 100
            albert = MahMixin::User.new 'Albert',  100
            assert_equal true,  (albert <  zander)
            assert_equal true,  (albert <= zander)
            assert_equal false, (albert >  zander)
            assert_equal false, (albert >= zander)
            assert_equal false, (albert == zander)
            assert_equal true, MahMixin::User.new('Bessy', 1) < MahMixin::User.new('Betty', 1)
          end
        end
        context 'when the left user\'s name is alphabetically later' do
          it 'is ordered later' do
            zander = MahMixin::User.new 'Zanzder', 100
            albert = MahMixin::User.new 'Albert',  100
            assert_equal false, (zander <  albert)
            assert_equal false, (zander <= albert)
            assert_equal true,  (zander >  albert)
            assert_equal true,  (zander >= albert)
            assert_equal false, (zander == albert)
            assert_equal true,  MahMixin::User.new('Bessy', 1) < MahMixin::User.new('Betty', 1)
          end
        end
        context 'when all the letters match' do
          it 'the one whose name is shorter is earlier' do
            sam      = MahMixin::User.new 'Sam',       100
            samantha = MahMixin::User.new 'Samantha',  100
            assert_equal true,  (sam <  samantha)
            assert_equal true,  (sam <= samantha)
            assert_equal false, (sam >  samantha)
            assert_equal false, (sam >= samantha)
            assert_equal false, (sam == samantha)
          end
        end
        context 'when the names are the same length' do
          it 'considers them equivalent' do
            sam1 = MahMixin::User.new 'Sam', 100
            sam2 = MahMixin::User.new 'Sam', 100
            assert_equal false, (sam1 <  sam2)
            assert_equal true,  (sam1 <= sam2)
            assert_equal false, (sam1 >  sam2)
            assert_equal true,  (sam1 >= sam2)
            assert_equal true,  (sam1 == sam2)
          end
        end
        specify 'name comparisons are not case sensitive' do
          usam = MahMixin::User.new('sam', 1)
          uSAM = MahMixin::User.new('SAM', 1)
          assert_equal false, (usam <  uSAM)
          assert_equal true,  (usam <= uSAM)
          assert_equal false, (usam >  uSAM)
          assert_equal true,  (usam >= uSAM)
          assert_equal true,  (usam == uSAM)
          assert_equal true,  (MahMixin::User.new("aa", 1) < MahMixin::User.new("aB", 1))
          assert_equal true,  (MahMixin::User.new("aA", 1) < MahMixin::User.new("aB", 1))
          assert_equal true,  (MahMixin::User.new("aA", 1) < MahMixin::User.new("ab", 1))
          assert_equal true,  (MahMixin::User.new("aA", 1) < MahMixin::User.new("aB", 1))
        end
      end
    end
  end
end
