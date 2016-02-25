Linked List Challenges
======================

To ease the transition from introducing abstraction into a linked list,
this repository has a lot of challenges that require you to work with a
linked list that is already built.

You'll write methods that do various useful things with it,
but won't have to build them from scratch yourself.
This should allow you to think about the algorithm without having
to also think about the data structure, which will hopefully
reduce the jump, and allow you to understand what the structure is,
and why it is that way.


To solve the challenges
-----------------------

Make sure you have mrspec installed (versions aren't very important)

```
$ gem install mrspec rspec
Successfully installed mrspec-0.3.1
Successfully installed rspec-3.4.0
2 gems installed
```

Run mrspec from the root of your project, with the `--fail-fast` flag
(this prevents the skipped tests from spamming your output),
you should see something like this:

```
$ mrspec --fail-fast

LinkedList
  given a linked list of strings return a linked list of the strings with more than 10 chars (PENDING: skipped)
  find the first item in a linked list (FAILED - 1)

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) LinkedList given a linked list of strings return a linked list of the strings with more than 10 chars
     # skipped
     Failure/Error: skip
       Skipped, no message given
     # ./test/linked_list_test.rb:339:in `test_given_a_linked_list_of_strings_return_a_linked_list_of_the_strings_with_more_than_10_chars'

Failures:
  ======================================================================
  1 | LinkedList find the first item in a linked list
  ======================================================================
  Expected: "a"
    Actual: nil
  test/linked_list_test.rb:54
     49:
     50:     list = LinkedList.new
     51:     assert_equal nil, first_item(list)
     52:
     53:     list = LinkedList.new(Node.new("a", nil))
  -> 54:     assert_equal "a", first_item(list)
     55:
     56:     list = LinkedList.new(Node.new("a", Node.new("b", nil)))
     57:     assert_equal "a", first_item(list)
     58:
     59:     list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
  ======================================================================
  test/linked_list_test.rb:54
           54: assert_equal "a", first_item(list)

Finished in 0.00244 seconds (files took 0.42488 seconds to load)
2 examples, 1 failure, 1 pending

Failed examples:

rspec /Users/josh/deleteme/linked_list_challenges/test/linked_list_test.rb:46 # LinkedList find the first item in a linked list
```

Notice in the failure that it shows us that we expected an `"a"`, but we got a `nil`.
This is for the example from line 54. So edit the `first_item` method in `lib/your_code_goes_here.rb`

If you get stuck
----------------

Put a pry at the spot where you don't know what to do,
or before something that is blowing up. Then you can look
at the list and at other local variables to get some context.

```ruby
From: /Users/josh/deleteme/linked_list_challenges/lib/your_code_goes_here.rb @ line 3 Object#first_item:

    1: def first_item(list)
    2:   require "pry"
 => 3:   binding.pry
    4: end

[1] pry(#<LinkedListTest>)> list
=> #<LinkedList:0x007fd6d8bf0e08 @head=#<Node:0x007fd6d8bf0e58 @data="a", @link=nil>>

[2] pry(#<LinkedListTest>)> ls list
LinkedList#methods: ==  head  head=
instance variables: @head

[3] pry(#<LinkedListTest>)> list.head
=> #<Node:0x007fd6d8bf0e58 @data="a", @link=nil>

[4] pry(#<LinkedListTest>)> ls list.head
Node#methods: ==  data  data=  link  link=
instance variables: @data  @link

[5] pry(#<LinkedListTest>)> list.head.data
=> "a"

[6] pry(#<LinkedListTest>)> exit
```
