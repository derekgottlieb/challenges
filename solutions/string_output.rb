# require 'stringio'
# StringOutput = StringIO
# __END__

class StringOutput
  attr_reader :string

  def initialize
    @closed_read  = false
    @closed_write = false
    @string       = ''
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
