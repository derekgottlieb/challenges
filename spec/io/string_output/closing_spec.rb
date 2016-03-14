require 'io/string_output/challenge'

RSpec.describe 'StringOutput' do
  include SpecHelpers

  describe 'closing' do
    describe 'close_read' do
      it 'returns nil' do
        output = StringOutput.new
        assert_equal nil, output.close_read
      end

      # NOTE: leaving it unspecified whether it can be called multiple times
      # since this behaviour changes in StringIO between Ruby 2.2.2 and 2.3.0
      # (due to whether it is considered "duplex" or not... possibly just a bug fixed in 2.2.2)
    end

    describe 'closed_read?' do
      it 'returns whether close_read has been called' do
        output = StringOutput.new
        assert_equal false, output.closed_read?
        output.close_read
        assert_equal true,  output.closed_read?
      end
    end

    describe 'close_write' do
      it 'returns nil' do
        output = StringOutput.new
        assert_equal nil, output.close_write
      end
    end

    describe 'closed_write?' do
      it 'returns whether close_write has been called' do
        output = StringOutput.new
        assert_equal false, output.closed_write?
        output.close_write
        assert_equal true,  output.closed_write?
      end
    end

    describe 'close' do
      it 'returns nil' do
        output = StringOutput.new
        assert_equal nil, output.close
      end

      it 'closes the read end and write end' do
        output = StringOutput.new
        assert_equal false, output.closed_read?
        assert_equal false, output.closed_write?
        output.close
        assert_equal true, output.closed_read?
        assert_equal true, output.closed_write?
      end
    end

    describe 'closed?' do
      specify 'is false when only the read end is closed' do
        output = StringOutput.new
        output.close_read
        assert_equal false, output.closed?
      end

      specify 'is false when only the write end is closed' do
        output = StringOutput.new
        output.close_write
        assert_equal false, output.closed?
      end

      specify 'is true when both read and write are closed' do
        output = StringOutput.new
        output.close_read
        output.close_write
        assert_equal true, output.closed?
      end

      specify 'which is the case when #close has been called' do
        output = StringOutput.new
        output.close
        assert_equal true, output.closed?
      end
    end

    context 'when the read end is closed' do
      let(:output) { StringOutput.new }
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
