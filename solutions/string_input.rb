# require 'stringio'
# StringInput = StringIO
# __END__

class StringInput
  def initialize(input_string)
    @stream       = input_string.dup
    @closed_read  = false
    @closed_write = false
  end

  def gets
    return nil if eof?
    index = @stream.index("\n") || -1
    line  = @stream[0..index]
    @stream.sub! line, ''
    line
  end

  def read
    return "" if eof?
    result, @stream = @stream, ""
    result
  end

  def getc
    return nil if eof?
    char, @stream = @stream[0], @stream[1..-1]
    char
  end

  def eof?
    raise IOError, "not opened for reading" if closed_read?
    @stream == ""
  end

  def close_read
    @closed_read = true
    nil
  end

  def closed_read?
    @closed_read
  end

  def close_write
    @closed_write = true
    nil
  end

  def closed_write?
    @closed_write
  end

  def close
    close_read
    close_write
  end

  def closed?
    closed_read? && closed_write?
  end

  def each_char(&block)
    block.call getc until eof?
    self
  end

  def each_line(&block)
    block.call gets until eof?
    self
  end

  alias each each_line

  def readlines
    lines = []
    each_line { |line| lines << line }
    lines
  end
end
