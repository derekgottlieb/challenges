require 'stringio'
StringInputOutput = StringIO
__END__

class StringInputOutput
  attr_reader :string

  def initialize(input_string='')
    @string       = ''
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

  def print(*strs)
    strs.each { |str| append str.to_s }
    nil
  end

  def puts(*strs)
    strs << '' if strs.empty?
    strs.each { |str|
      str = str.to_s
      str += "\n" unless str.end_with? "\n"
      append str
    }
    nil
  end

  def write(str)
    str = str.to_s
    append str
    str.bytesize
  end

  def <<(str)
    write str
    self
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

  def printf(format_string, *args)
    print (format_string % args)
  end

  private

  def append(str)
    raise IOError, 'not opened for writing' if closed_write?
    @string << str
  end
end
