require 'iterable/challenge'

RSpec.describe 'preparing Ooll for Iterable' do
  describe 'Ooll.[]' do
    specify 'I know how to declare methods on the singleton class' do
      # https://synseer.herokuapp.com/games/singleton_methods_on_local_variable
      # https://synseer.herokuapp.com/games/singleton_methods_on_instance_variable
      # https://synseer.herokuapp.com/games/singleton_methods_on_constant_variable
      # https://synseer.herokuapp.com/games/singleton_methods_on_self
      # https://synseer.herokuapp.com/games/singleton_methods_on_class
      i_see_this_helpful_stuff_here false
    end

    specify 'I know how to make a method that takes an arbitrary number of arguments' do
      # https://synseer.herokuapp.com/games/methods_can_collect_the_rest_of_their_parameters_into_an_array
      # https://synseer.herokuapp.com/games/all_parameter_types_together
      # https://synseer.herokuapp.com/games/you_can_pass_array_elements_as_arguments_with_an_asterisk
      # https://synseer.herokuapp.com/games/expanding_ranges_into_arrays
      # https://synseer.herokuapp.com/games/convenient_enumerables
      # https://synseer.herokuapp.com/games/silence_destroy_him
      i_see_this_helpful_stuff_here false
    end

    specify 'If you don\'t know what to do from the previous two' do
      # playing around with the syntax you saw
      # making predictions about what will happen
      # performing an experiment to see if you're right
      i_see_this_helpful_stuff_here false
    end


    it 'is a method that can be called on Ooll directly' do
      assert_equal true, Ooll.respond_to?(:[])
    end

    it 'is not defined on classes generally' do
      assert_equal false, Class.new.respond_to?(:[])
    end

    it 'returns an empy list when called with no args' do
      list = Ooll[]
      assert_equal nil, list[0]
    end

    it 'returns a list with just the item in it, when given one item' do
      list = Ooll['a']
      assert_equal 'a', list[0]
      assert_equal nil, list[1]
    end

    it 'returns a list with multiple items, in order, when given multiple items' do
      list = Ooll['a', 'b']
      assert_equal 'a', list[0]
      assert_equal 'b', list[1]
      assert_equal nil, list[2]
    end

    it 'can take an arbitrary number of args, and adds them all into the list' do
      list = Ooll['a', 'b', 'c', 'd', 'e']
      assert_equal 'a', list[0]
      assert_equal 'b', list[1]
      assert_equal 'c', list[2]
      assert_equal 'd', list[3]
      assert_equal 'e', list[4]
      assert_equal nil, list[5]
    end
  end


  describe 'each' do
    specify 'I know how to do declare my own each method' do
      # https://vimeo.com/156462575
      i_see_this_helpful_stuff_here false
    end


    it 'does not call the block when the list is empty' do
      seen = []
      Ooll[].each { |item| seen << item }
      assert_equal [], seen
    end

    it 'calls the block with the item when there is one item in the list' do
      seen = []
      Ooll["a"].each { |item| seen << item }
      assert_equal ["a"], seen
    end

    it 'calls the block with each of the items in the list, when there are many items in the list' do
      seen = []
      Ooll['a', 'b', 'c', 'd', 'e', 'f'].each { |item| seen << item }
      assert_equal %w[a b c d e f], seen
    end

    it 'returns the list' do
      list = Ooll.new
      assert_equal list, list.each { }
      list << 'a'
      assert_equal list, list.each { }
      list << 'b'
      assert_equal list, list.each { }
      list << 'c'
      assert_equal list, list.each { }
    end

    it 'does not modify the list' do
      list = Ooll['a', 'b', 'c']
      list.each { }
      assert_equal 'a', list[0]
      assert_equal 'b', list[1]
      assert_equal 'c', list[2]
    end
  end


  describe 'Iterable and Ooll' do
    specify 'I know what a module is and what inclusion allows' do
      # Examples in the initial project description
      #   https://github.com/CodePlatoon/curriculum/blob/c459e95c816da69ea2a9807c0fdd57ab18262830/phase1/iterable_project.md
      # Video of us going through the above material
      #   https://vimeo.com/157849877
      i_see_this_helpful_stuff_here false
    end

    specify 'I know there are challenges specifically for module inclusion' do
      # Challenges for module inclusion
      #   https://github.com/JoshCheek/challenges/blob/master/spec/module_challenges/include_spec.rb
      i_see_this_helpful_stuff_here false
    end

    specify 'I know the code for Iterable goes in the file iterable.rb' do
      i_see_this_helpful_stuff_here false
    end

    specify 'I know my Ooll is the one that should require it' do
      # since that's where it is used
      i_see_this_helpful_stuff_here false
    end

    specify 'Iterable is a module' do
      assert_equal Module, Iterable.class
    end

    specify 'Iterable is included into Ooll' do
      assert_equal true, Ooll.ancestors.include?(Iterable)
    end
  end
end
