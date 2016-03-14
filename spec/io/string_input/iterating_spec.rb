require 'io/string_input/challenge'

RSpec.describe 'StringInput' do
  include SpecHelpers

  describe 'iterating / collections' do
    describe 'each_char' do
      it 'receives a block and calls it once for each char of the input' do
        input = StringInput.new "ab\ncd"
        seen  = []
        input.each_char { |c| seen << c }
        assert_equal ["a", "b", "\n", "c", "d"], seen
      end
      it 'returns the input object' do
        input    = StringInput.new "ab\ncd"
        returned = input.each_char { |c| }
        assert_equal input, returned
      end
      it 'consumes the input' do
        input    = StringInput.new "ab\ncd"
        returned = input.each_char { |c| }
        assert_equal true, input.eof?
      end
      it 'is affected by modifications to the input that occur during iteration' do
        input = StringInput.new "abcd"
        yielded, other = [], []
        input.each_char do |c|
          yielded << c
          other   << input.getc
        end
        assert_equal ['a', 'c'], yielded
        assert_equal ['b', 'd'], other
      end
    end

    describe 'each_line' do
      it 'receives a block and calls it once for each line of the input' do
        input = StringInput.new "ab\ncd"
        seen  = []
        input.each_line { |l| seen << l }
        assert_equal ["ab\n", "cd"], seen
      end
      it 'returns the input object' do
        input    = StringInput.new "ab\ncd"
        returned = input.each_line { |l| }
        assert_equal input, returned
      end
      it 'consumes the input' do
        input    = StringInput.new "ab\ncd"
        returned = input.each_line { |l| }
        assert_equal true, input.eof?
      end
      it 'is affected by modifications to the input that occur during iteration' do
        input = StringInput.new "abc\ndef\nghi\n"
        yielded, other = [], []
        input.each_line do |line|
          yielded << line
          other   << input.getc
        end
        assert_equal ["abc\n", "ef\n", "hi\n"], yielded
        assert_equal ["d", "g", nil], other
      end
    end

    describe 'each -- a shorthand for each_line' do
      it 'receives a block and calls it once for each line of the input' do
        input = StringInput.new "ab\ncd"
        seen  = []
        input.each { |l| seen << l }
        assert_equal ["ab\n", "cd"], seen
      end
      it 'returns the input object' do
        input    = StringInput.new "ab\ncd"
        returned = input.each { |l| }
        assert_equal input, returned
      end
      it 'consumes the input' do
        input    = StringInput.new "ab\ncd"
        returned = input.each { |l| }
        assert_equal true, input.eof?
      end
      it 'is affected by modifications to the input that occur during iteration' do
        input = StringInput.new "abc\ndef\nghi\n"
        yielded, other = [], []
        input.each do |line|
          yielded << line
          other   << input.getc
        end
        assert_equal ["abc\n", "ef\n", "hi\n"], yielded
        assert_equal ["d", "g", nil], other
      end
    end
    describe 'readlines' do
      it 'returns an array of the lines of input' do
        assert_equal [], StringInput.new('').readlines
        assert_equal ["a"], StringInput.new("a").readlines
        assert_equal ["ab\n", "cd\n"], StringInput.new("ab\ncd\n").readlines
      end
    end
  end
end
