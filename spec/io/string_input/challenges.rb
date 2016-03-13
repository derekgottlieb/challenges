require 'spec_helper'
require 'string_input'

RSpec.describe 'StringInput' do
  include SpecHelpers

  describe 'reading input' do
    describe 'gets' do
      it 'consumes and returns the input until it finds a newline' do
        input = StringInput.new "abc\ndef\n"
        assert_equal "abc\n", input.gets
        assert_equal "def\n", input.gets
      end
      it 'consumes to the end of the input, if there is no newline' do
        input = StringInput.new "abc"
        assert_equal "abc", input.gets
      end
      it 'returns nil when there is no more input' do
        input = StringInput.new ""
        assert_equal nil, input.gets
        assert_equal nil, input.gets
      end
      it 'considers a newline all by itself to be a line' do
        input = StringInput.new "\na"
        assert_equal "\n", input.gets
        assert_equal "a",  input.gets
      end
      it 'does all of these together' do
        input = StringInput.new "lol\nwtf\n"
        assert_equal "lol\n", input.gets
        assert_equal "wtf\n", input.gets
        assert_equal nil,     input.gets
      end
      it 'only considers the newline and end-of-input as line-ends' do
        all_ascii_chars = (0...127).map(&:chr).join
        input           = StringInput.new all_ascii_chars

        assert_equal "\x00\x01\x02\x03\x04\x05\x06\a\b\t\n",
                     input.gets

        assert_equal "\v\f\r\x0E\x0F\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1A\e\x1C\x1D\x1E\x1F !\"\#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
                     input.gets

        assert_equal nil, input.gets
        assert_equal nil, input.gets
      end
    end

    describe 'read' do
      it 'consumes the rest of the input' do
        input = StringInput.new "abc\ndef"
        assert_equal "abc\ndef", input.read
      end

      it 'returns an empty string when there is no input' do
        input = StringInput.new ""
        assert_equal "", input.read
      end

      it 'returns an empty string when there is no more input' do
        input = StringInput.new "abc\ndef\n"
        assert_equal "abc\ndef\n", input.read
        assert_equal "", input.read
        assert_equal "", input.read
      end
    end

    describe 'getc' do
      it 'consumes the next character of input' do
        input = StringInput.new "abc\ndef"
        assert_equal "a", input.getc
        assert_equal "b", input.getc
        assert_equal "c", input.getc
        assert_equal "\n", input.getc
        assert_equal "d", input.getc
        assert_equal "e", input.getc
        assert_equal "f", input.getc
      end

      it 'returns nil when there is no more input' do
        input = StringInput.new "a"
        assert_equal "a", input.getc
        assert_equal nil, input.getc
        assert_equal nil, input.getc
      end
    end

    describe 'eof? (end of "file")' do
      it 'returns whether it is out of input' do
        input = StringInput.new ""
        assert_equal true, input.eof?

        input = StringInput.new "a"
        assert_equal false, input.eof?
      end

      it 'considers any unconsumed characters, including newlines to be input' do
        input = StringInput.new "\n"
        assert_equal false, input.eof?
      end

      it 'works with gets' do
        input = StringInput.new "a\nb\n"
        assert_equal false, input.eof?
        assert_equal "a\n", input.gets
        assert_equal false, input.eof?
        assert_equal "b\n", input.gets
        assert_equal true,  input.eof?
      end

      it 'works with read' do
        input = StringInput.new "ab"
        assert_equal false, input.eof?
        assert_equal "ab",  input.read
        assert_equal true,  input.eof?
      end

      it 'works with getc' do
        input = StringInput.new "ab"
        assert_equal false, input.eof?
        assert_equal "a",   input.getc
        assert_equal false, input.eof?
        assert_equal "b",   input.getc
        assert_equal true,  input.eof?
      end
    end

    context 'all of these together' do
      specify 'they are all consuming the same input, so they all work together' do
        string = "abc\ndef\nghi"
        input  = StringInput.new string
        assert_equal false,   input.eof?
        assert_equal "a",     input.getc
        assert_equal false,   input.eof?
        assert_equal "bc\n",  input.gets
        assert_equal false,   input.eof?
        assert_equal "d",     input.getc
        assert_equal false,   input.eof?
        assert_equal "e",     input.getc
        assert_equal false,   input.eof?
        assert_equal "f",     input.getc
        assert_equal false,   input.eof?
        assert_equal "\nghi", input.read
        assert_equal true,    input.eof?
        assert_equal "",      input.read
        assert_equal true,    input.eof?
        assert_equal nil,     input.getc
        assert_equal true,    input.eof?
        assert_equal nil,     input.gets
        assert_equal true,    input.eof?

        # shows that string is unmodified
        assert_equal "abc\ndef\nghi", string
      end
    end
  end


  describe 'closing' do
    describe 'close_read' do
      it 'returns nil' do
        input = StringInput.new("abc")
        assert_equal nil, input.close_read
      end

      # NOTE: leaving it unspecified whether it can be called multiple times
      # since this behaviour changes in StringIO between Ruby 2.2.2 and 2.3.0
      # (due to whether it is considered "duplex" or not... possibly just a bug fixed in 2.2.2)
    end

    describe 'closed_read?' do
      it 'returns whether close_read has been called' do
        input = StringInput.new("abc")
        assert_equal false, input.closed_read?
        input.close_read
        assert_equal true,  input.closed_read?
      end
    end

    describe 'close_write' do
      it 'returns nil' do
        input = StringInput.new("abc")
        assert_equal nil, input.close_write
      end
    end

    describe 'closed_write?' do
      it 'returns whether close_write has been called' do
        input = StringInput.new("abc")
        assert_equal false, input.closed_write?
        input.close_write
        assert_equal true,  input.closed_write?
      end
    end

    describe 'close' do
      it 'returns nil' do
        input = StringInput.new("abc")
        assert_equal nil, input.close
      end

      it 'closes the read end and write end' do
        input = StringInput.new("abc")
        assert_equal false, input.closed_read?
        assert_equal false, input.closed_write?
        input.close
        assert_equal true, input.closed_read?
        assert_equal true, input.closed_write?
      end
    end

    describe 'closed?' do
      specify 'is false when only the read end is closed' do
        input = StringInput.new("abc")
        input.close_read
        assert_equal false, input.closed?
      end

      specify 'is false when only the write end is closed' do
        input = StringInput.new("abc")
        input.close_write
        assert_equal false, input.closed?
      end

      specify 'is true when both read and write are closed' do
        input = StringInput.new("abc")
        input.close_read
        input.close_write
        assert_equal true, input.closed?
      end

      specify 'which is the case when #close has been called' do
        input = StringInput.new("abc")
        input.close
        assert_equal true, input.closed?
      end
    end

    context 'when the read end is closed' do
      let(:input) { StringInput.new "abc" }
      before { input.close_read }

      specify '#gets raises IOError' do
        assert_raises(IOError, 'not opened for reading') { input.gets }
      end

      specify '#read raises IOError' do
        assert_raises(IOError, 'not opened for reading') { input.read }
      end

      specify '#getc raises IOError' do
        assert_raises(IOError, 'not opened for reading') { input.getc }
      end

      specify '#eof? raises IOError' do
        assert_raises(IOError, 'not opened for reading') { input.eof? }
      end
    end
  end


  describe 'iterating / collections' do
    describe 'each'
    describe 'each_byte'
    describe 'each_char'
    describe 'each_line'
    describe 'readlines'
  end
end

__END__
reading input
  gets
    consumes and returns the input until it finds a newline
    consumes to the end of the input, if there is no newline
    returns nil when there is no more input
    when the read is closed, raises IOError: not opened for reading
  read
    consumes the rest of the input
    when the read is closed, raises IOError: not opened for reading
  getc
    consumes the next character of input
    when the read is closed, raises IOError: not opened for reading
  eof?
    true when there is no more input
    when the read is closed, raises IOError: not opened for reading

closing
  close_read
    returns nil
  closed_read?
    true if close_read has been called
  close_write
    returns nil
  closed_write?
    true if close_read has been called
  close
    closes the read end and write end
  closed?
    true if the read end is closed and the write end is closed

iterating / collections
  each
  each_byte
  each_char
  each_line
  readlines
