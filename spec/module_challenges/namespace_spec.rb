require 'module_challenges/challenges'

# to add: using toplevel scope resolution operator
RSpec.describe 'modules as namespaces' do
  specify 'define a module MahMod' do
    assert_equal Module, MahMod.class
  end
  specify 'define a module MahMod::A' do
    assert_equal Module, MahMod::A.class
  end
  specify 'define a module MahMod::B' do
    assert_equal Module, MahMod::B.class
  end
  specify 'define a MahMod::A::C with a value of 1' do
    assert_equal 1, MahMod::A::C
  end
  specify 'define a MahMod::B::C with a value of 2' do
    assert_equal 2, MahMod::B::C
  end

  describe 'MahMod.find_c (you can do this as a method on the singleton class)' do
    it 'finds MahMod::A::C when given MahMod::A' do
      assert_equal 1, MahMod.find_c(MahMod::A)
    end
    it 'finds MahMod::B::C when given MahMod::B' do
      assert_equal 2, MahMod.find_c(MahMod::B)
    end
    it 'finds <ArbitraryMod>::C when given <ArbitraryMod>' do
      wat_mod = Module.new { const_set :C, 'wat' }
      lol_mod = Module.new { const_set :C, 'lol' }
      assert_equal 'wat', MahMod.find_c(wat_mod)
      assert_equal 'lol', MahMod.find_c(lol_mod)
    end
  end

  describe 'MahMod::String' do
    it 'is the toplevel String class' do
      assert_equal ::String, MahMod::String
    end
  end

  describe 'MahMod::Dir' do
    it 'is the string "These aren\'t the Dirs you\'re looking for"' do
      assert_equal "These aren't the Dirs you're looking for", MahMod::Dir
    end
    specify 'MahMod.mah_dir returns MahMod\'s Dir (do this without referencing MahMod)' do
      assert_equal MahMod::Dir, MahMod.mah_dir
      # literally the same object, not just the same string
      assert_equal true, MahMod::Dir.equal?(MahMod.mah_dir)
    end
    specify 'top_dir returns the normal Dir class' do
      assert_equal ::Dir, MahMod.top_dir
    end
  end


  describe 'MahMod.make_mod' do
    it 'returns a module' do
      assert_equal Module, MahMod.make_mod("a").class
    end
    it 'is an anonymous module (not assigned to a constant)' do
      assert_equal nil, MahMod.make_mod("a").name
    end
    it 'returns a different module every time' do
      assert_equal false, (MahMod.make_mod("a") == MahMod.make_mod("a"))
    end
    it 'sets its argument as a constant named ARG (use Module#set_const)' do
      assert_equal "a", MahMod.make_mod("a")::ARG
      assert_equal "b", MahMod.make_mod("b")::ARG
    end
  end


  describe 'MahMod::List, a linked list using constants' do
    specify 'do what you need to do to make this example work' do
      list = MahMod::List.new

      list.unshift "a"
      assert_equal "a", list.head::DATA
      assert_equal nil, list.head::LINK

      list.unshift "b"
      assert_equal "b", list.head::DATA
      assert_equal "a", list.head::LINK::DATA
      assert_equal nil, list.head::LINK::LINK

      list.unshift "c"
      assert_equal "c", list.head::DATA
      assert_equal "b", list.head::LINK::DATA
      assert_equal "a", list.head::LINK::LINK::DATA
      assert_equal nil, list.head::LINK::LINK::LINK
    end
  end
end
