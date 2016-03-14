require 'io/string_input_output/challenge'

RSpec.describe 'StringInputOutput' do
  include SpecHelpers

  describe 'closing' do
    describe 'close_read' do
      it 'returns nil' do
        input = StringInputOutput.new("abc")
        assert_equal nil, input.close_read
      end

      # NOTE: leaving it unspecified whether it can be called multiple times
      # since this behaviour changes in StringIO between Ruby 2.2.2 and 2.3.0
      # (due to whether it is considered "duplex" or not... possibly just a bug fixed in 2.2.2)
    end

    describe 'closed_read?' do
      it 'returns whether close_read has been called' do
        input = StringInputOutput.new("abc")
        assert_equal false, input.closed_read?
        input.close_read
        assert_equal true,  input.closed_read?
      end
    end

    describe 'close_write' do
      it 'returns nil' do
        input = StringInputOutput.new("abc")
        assert_equal nil, input.close_write
      end
    end

    describe 'closed_write?' do
      it 'returns whether close_write has been called' do
        input = StringInputOutput.new("abc")
        assert_equal false, input.closed_write?
        input.close_write
        assert_equal true,  input.closed_write?
      end
    end

    describe 'close' do
      it 'returns nil' do
        input = StringInputOutput.new("abc")
        assert_equal nil, input.close
      end

      it 'closes the read end and write end' do
        input = StringInputOutput.new("abc")
        assert_equal false, input.closed_read?
        assert_equal false, input.closed_write?
        input.close
        assert_equal true, input.closed_read?
        assert_equal true, input.closed_write?
      end
    end

    describe 'closed?' do
      specify 'is false when only the read end is closed' do
        input = StringInputOutput.new("abc")
        input.close_read
        assert_equal false, input.closed?
      end

      specify 'is false when only the write end is closed' do
        input = StringInputOutput.new("abc")
        input.close_write
        assert_equal false, input.closed?
      end

      specify 'is true when both read and write are closed' do
        input = StringInputOutput.new("abc")
        input.close_read
        input.close_write
        assert_equal true, input.closed?
      end

      specify 'which is the case when #close has been called' do
        input = StringInputOutput.new("abc")
        input.close
        assert_equal true, input.closed?
      end
    end

    context 'when the read end is closed' do
      let(:input) { StringInputOutput.new "abc" }
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
end


RSpec.describe 'StringInputOutput' do
  include SpecHelpers

  describe 'closing' do
    describe 'close_read' do
      it 'returns nil' do
        output = StringInputOutput.new
        assert_equal nil, output.close_read
      end

      # NOTE: leaving it unspecified whether it can be called multiple times
      # since this behaviour changes in StringIO between Ruby 2.2.2 and 2.3.0
      # (due to whether it is considered "duplex" or not... possibly just a bug fixed in 2.2.2)
    end

    describe 'closed_read?' do
      it 'returns whether close_read has been called' do
        output = StringInputOutput.new
        assert_equal false, output.closed_read?
        output.close_read
        assert_equal true,  output.closed_read?
      end
    end

    describe 'close_write' do
      it 'returns nil' do
        output = StringInputOutput.new
        assert_equal nil, output.close_write
      end
    end

    describe 'closed_write?' do
      it 'returns whether close_write has been called' do
        output = StringInputOutput.new
        assert_equal false, output.closed_write?
        output.close_write
        assert_equal true,  output.closed_write?
      end
    end

    describe 'close' do
      it 'returns nil' do
        output = StringInputOutput.new
        assert_equal nil, output.close
      end

      it 'closes the read end and write end' do
        output = StringInputOutput.new
        assert_equal false, output.closed_read?
        assert_equal false, output.closed_write?
        output.close
        assert_equal true, output.closed_read?
        assert_equal true, output.closed_write?
      end
    end

    describe 'closed?' do
      specify 'is false when only the read end is closed' do
        output = StringInputOutput.new
        output.close_read
        assert_equal false, output.closed?
      end

      specify 'is false when only the write end is closed' do
        output = StringInputOutput.new
        output.close_write
        assert_equal false, output.closed?
      end

      specify 'is true when both read and write are closed' do
        output = StringInputOutput.new
        output.close_read
        output.close_write
        assert_equal true, output.closed?
      end

      specify 'which is the case when #close has been called' do
        output = StringInputOutput.new
        output.close
        assert_equal true, output.closed?
      end
    end

    context 'when the read end is closed' do
      let(:output) { StringInputOutput.new }
      before { output.close_write }

      specify '#print raises IOError' do
        assert_raises(IOError, 'not opened for writing') { output.print "abc" }
      end

      specify '#puts raises IOError' do
        assert_raises(IOError, 'not opened for writing') { output.puts "abc" }
      end

      specify '#write raises IOError' do
        assert_raises(IOError, 'not opened for writing') { output.write 'a' }
      end

      specify '#<< raises IOError' do
        assert_raises(IOError, 'not opened for writing') { output << 'a' }
      end

      specify '#printf raises IOError' do
        assert_raises(IOError, 'not opened for writing') { output.printf '%d', 1 }
      end
    end
  end
end
