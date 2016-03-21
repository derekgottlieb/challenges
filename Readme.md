Challenges
==========

A place to practice, a place to grow, a place to see if you really do know.

These are various programming challenges centered around solidifying knowledge,
and practicing things we may have forgotten, but still need to use.


What you need
-------------

I ran these all with `mrspec`.
You can get it with `$ bundle install`
(if it gets upset that you don't have Bundler, then first `$ gem install bundler`).
The individual challenges will provide more information on how to run them.



Suggested Order
---------------

* [linked list functions](spec/linked_list_functions)
* [block challenges](spec/block_challenges)
* [module challenges](spec/module_challenges)
* [iterable](spec/iterable)
* [general recursion](spec/general_recursion)
* [list recursion](spec/list_recursion)
* [io](spec/io)


Running an individual challenge
-------------------------------

This differs slightly between examples, based on
whether you need to do them in order or not.
See each set of challenges to identify how to run them.
Once you have them all passing, though,
you can run them with `$ bundle exec mrspec` from the root of the project.

If you want to run a specific test, you can pass a hash to the
test method, eg I'll choose "crnt: true". The key you choose will
be considered a "tag"

```ruby
it 'does something', crnt: true do
  assert_equal 1, 1
end
```

Then you can tell mrspec to run the ones that are tagged like this.

```ruby
$ bundle exec mrspec -t crnt
```


Strategies
----------

* Read the readmes for each set of challenges before attempting them.
* Read the names of the tests before trying to solve any,
  the most useful thing for succeeding is keeping the context
  of what you're supposed to be doing.
* Read the error messages, take the time to analyze all the information
  to understand what it is telling you and why it is telling you that.
  I went to great effort to make the error messages as helpful as I could,
* Go as far as you can, when you get stuck, try a different challenge.
* Collaborate with others, their ideas will give you valuable insight.
  Collaborate is not a synonym for copy, you want to share ideas,
  not solutions.
* First go through these methodically (slowly, deliberately, attentively),
  then try to go through them quicker (same outcome, less time spent figuring things out).
  You're training yourself to quickly analyze and execute.
  There's a reason I'm fast, it's because I practice. A lot.


You probably can't beat these
-----------------------------

The intent is that they get increasingly difficult,
so that each person can find their horizon of ability,
and push it further out. This means that the challenges
need to be harder than any student is likely to solve.

So, when you hit a wall, move on to a different set of challenges.
You can always return later, and the experience you gain in the
interim will improve your ability to solve the ones you struggle with.


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


When Context is making it difficult to do something easy
--------------------------------------------------------

Figure out what the real question is, and answer that question in
isolation. Then bring the answer back into the difficult context.
Do you just need to figure out what happens when you ask a hash
for an item that it doesn't have? Don't solve that in the middle
of some big problem, solve it in isolation, where you can experiment
to determine the answer in just a single line of code. Then bring
the answer back with you and apply it to the context you're trying
to solve.
