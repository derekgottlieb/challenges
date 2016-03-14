IO
==

Get comfortable working with stdin, stdout, sockets,
pipes... and generally any IO object. You see, they're
all pretty much the same.


Suggested Order
---------------

* StringInput. Reading input is the the most valuable,
  closing is second most, iterating is third most.
  If you don't know what to do for iterating,
  you can go to another challenge, or go try the block challenge.

  ```ruby
  $ mrspec spec/io/string_input/reading_input_spec.rb
  $ mrspec spec/io/string_input/closing_spec.rb
  $ mrspec spec/io/string_input/iterating_spec.rb
  ```
* StringOutput. Writing output is the the most valuable,
  closing is second most, iterating is third most.

  ```ruby
  $ mrspec spec/io/string_output/writing_output_spec.rb
  $ mrspec spec/io/string_output/closing_spec.rb
  ```
* StringInputOutput. This probably seems familiar...
  Try refactoring to reduce duplication.

  ```ruby
  $ mrspec spec/io/string_input_output/reading_input_spec.rb
  $ mrspec spec/io/string_input_output/writing_output_spec.rb
  $ mrspec spec/io/string_input_output/closing_spec.rb
  $ mrspec spec/io/string_input_output/iterating_spec.rb
  ```
