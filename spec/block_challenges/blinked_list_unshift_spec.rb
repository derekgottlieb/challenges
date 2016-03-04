require 'block_challenges/challenges'

RSpec.describe 'blinked_list_unshift' do
  it 'receives some data and a proc' do
    link = Proc.new { }
    blinked_list_unshift "Savannah", link
  end

  describe 'the return value' do
    it 'is a new Proc' do
      link = Proc.new { }
      returned = blinked_list_unshift link, nil
      assert_equal Proc, returned.class
      assert_equal false, returned == link
    end

    it 'the proc returns the data if I call it with :data' do
      link = Proc.new { }
      returned = blinked_list_unshift link, :abc
      assert_equal :abc, returned.call(:data)
    end

    it 'the proc returns the link if I call it with :link' do
      link = Proc.new { }
      returned = blinked_list_unshift link, :abc
      assert_equal link, returned.call(:link)
    end

    it 'raises an ArgumentError if given a value other than :data or :link' do
      raised = false
      begin
        link = Proc.new { }
        returned = blinked_list_unshift link, :abc
        returned.call(:datta)
      rescue ArgumentError => err
        raised = true
        assert_equal "expected :data or :link, got :datta", err.message
      end
      assert_equal true, raised
    end

    example 'bigger example' do
      list = blinked_list_unshift nil,  1
      list = blinked_list_unshift list, 'a'
      list = blinked_list_unshift list, :lol
      assert_equal :lol, list.call(:data)
      assert_equal "a",  list.call(:link).call(:data)
      assert_equal 1,    list.call(:link).call(:link).call(:data)
      assert_equal nil,  list.call(:link).call(:link).call(:link)
    end
  end
end
