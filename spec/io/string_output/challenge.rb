require 'spec_helper'
# require 'string_output'

RSpec.describe 'StringInput' do
  include SpecHelpers
end
__END__
writing output
  print
    returns nil
    prints any number of lines
    calls #to_s on its args
  puts
  write
    returns the number of bytes written
  <<
    alias for write
  printf
  putc

closing
  close_read
  close_write
  closed_read?
  closed_write?
  close
  closed?
