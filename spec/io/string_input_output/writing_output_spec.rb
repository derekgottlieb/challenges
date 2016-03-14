require 'io/string_input_output/challenge'

RSpec.describe 'StringInputOutput' do
  include SpecHelpers

  let(:output) { StringInputOutput.new }

  describe '#string' do
    it 'lets me see what was printed' do
      assert_equal '', output.string
    end
  end

  describe 'writing output' do
    describe '#print' do
      it 'returns nil' do
        assert_equal nil, output.print('a')
      end

      it 'prints into an internal string' do
        output.print("abc")
        assert_equal "abc", output.string

        output.print("def")
        assert_equal "abcdef", output.string
      end

      it 'can be given multiple arguments to print' do
        output.print
        output.print('a')
        output.print('b', 'c')
        hundred_inputs = 20.times.map(&:to_s)
        output.print(*hundred_inputs)
        assert_equal "abc012345678910111213141516171819", output.string
      end

      it 'prints what its arguments return from to_s' do
        output.print(123, "abc", :def, /123/)
        assert_equal "123abcdef(?-mix:123)", output.string
      end

      it 'does not modify the input or the input\'s to_s' do
        str_arg    = "abc"
        to_s       = "def"
        nonstr_arg = Object.new
        nonstr_arg.define_singleton_method(:to_s) { to_s }

        output.print str_arg, nonstr_arg

        assert_equal "abcdef", output.string
        assert_equal "abc",    str_arg
        assert_equal "def",    to_s
      end
    end

    describe '#puts' do
      it 'returns nil' do
        assert_equal nil, output.puts('a')
      end

      it 'prints the argument.to_s and a newline' do
        output.puts("abc")
        assert_equal "abc\n", output.string

        output.puts("def")
        assert_equal "abc\ndef\n", output.string
      end

      it 'does not print a newline if there is already one at the end of the thing to print' do
        output.puts("abc\n")
        assert_equal "abc\n", output.string

        output.puts("def")
        assert_equal "abc\ndef\n", output.string

        output.puts("ghi\n")
        assert_equal "abc\ndef\nghi\n", output.string

        output.puts("jkl\nmno")
        assert_equal "abc\ndef\nghi\njkl\nmno\n", output.string
      end

      it 'prints an empty line if called with no arguments' do
        output.puts
        output.puts
        assert_equal "\n\n", output.string
      end

      it 'can be given multiple arguments to print' do
        output.puts
        output.puts "a"
        output.puts "b", "c"
        assert_equal "\na\nb\nc\n", output.string
      end

      it 'does not modify the input or the input\'s to_s' do
        str_arg    = "abc"
        to_s       = "def"
        nonstr_arg = Object.new
        nonstr_arg.define_singleton_method(:to_s) { to_s }

        output.puts str_arg, nonstr_arg

        assert_equal "abc\ndef\n", output.string
        assert_equal "abc",        str_arg
        assert_equal "def",        to_s
      end
    end

    describe '#write' do
      it 'prints the string' do
        output.write "abc"
        output.write "def"
        assert_equal 'abcdef', output.string
      end
      it 'prints what its arguments return from to_s' do
        output.write 123
        output.write "abc"
        output.write :def
        output.write /123/
        assert_equal "123abcdef(?-mix:123)", output.string
      end
      it 'returns the number of bytes printed -- use pry to list out what strings can do and grep for things dealing with bytes' do
        assert_equal 3, output.write('abc')
        assert_equal 4, output.write('ab¢')
      end
      it 'does not modify the input or the input\'s to_s' do
        str_arg    = "abc"
        to_s       = "def"
        nonstr_arg = Object.new
        nonstr_arg.define_singleton_method(:to_s) { to_s }

        output.write str_arg
        output.write nonstr_arg

        assert_equal "abcdef", output.string
        assert_equal "abc",    str_arg
        assert_equal "def",    to_s
      end
    end

    describe '<<' do
      it 'prints the string' do
        output << "abc"
        output << "def"
        assert_equal 'abcdef', output.string
      end
      it 'prints what its arguments return from to_s' do
        output << 123
        output << "abc"
        output << :def
        output << /123/
        assert_equal "123abcdef(?-mix:123)", output.string
      end
      it 'returns the object' do
        returned = output << 'abc'
        assert_equal output, returned
      end
      it 'does not modify the input or the input\'s to_s' do
        str_arg    = "abc"
        to_s       = "def"
        nonstr_arg = Object.new
        nonstr_arg.define_singleton_method(:to_s) { to_s }

        output << str_arg
        output << nonstr_arg

        assert_equal "abcdef", output.string
        assert_equal "abc",    str_arg
        assert_equal "def",    to_s
      end
    end

    describe 'printf -- delegate the hard work to Kernel#sprintf or String#%' do
      it 'returns nil' do
        assert_equal nil, output.printf("a %d b", 1)
      end
      it 'receives a format string, and arguments, which it formats accordingly and prints into the string' do
        output.printf "abc %d efg", 123
        assert_equal "abc 123 efg", output.string
      end
    end
  end
end
