require 'io/string_input/challenge'

RSpec.describe 'StringInput' do
  include SpecHelpers

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
end
