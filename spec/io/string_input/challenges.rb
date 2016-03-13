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
