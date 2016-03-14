Block Challenges
================

Purpose
-------

The coolest parts of Ruby use blocks.
The purpose of this one is to gain the ability to use blocks ourselves.
You'll need this one if you want to build your own Enumerable,
or to simplify some of the otherwise difficult challenges.


To run
------

Each function has its own file to test that it works.
Find the file for the one you want to try and run it like this:

```sh
$ mrspec spec/block_challenges/block_to_proc_spec.rb
```


Suggested Order
---------------

The order here isn't very important.
I put them in the order that I think is probably
most linear, but that will change for each person.


* First:

  ```ruby
  block_to_proc(&block)
  wrap(value)
  ```
* Second:
  Then go through the challenges in
  `call_twice_and_thrice_spec.rb`,
  it will repeat a lot... when you see the pattern,
  you can save yourself a lot of effort.
* `yield_with_while_loop(array, &block)` gives you an array that only
  has brackets and length. You'll have to solve this one
  the way they do in C.
* `yield_with_each` gives you an array that only has
  `each`, you'll have to use that method to iterate over the array.
* `best_advice(array, &block)`
* `blinked_list_unshift(link, &data)`
  Here we get another take on what it means to be a linked list.
  This simply plays with the mechanics, using local variables to store
  the link and data, and returning a piece of code that can get the desired
  data at aa later point in time, depending on what you call it with.
* `aside`, this is a method that Ruby actually defines for you... just under a different name :)
* Then we try to get more realistic, defining classes that look more like what you might see in real code.
  Again, there is no real order here, it's just my guess.

  ```ruby
  PubSubSimple
  OnCount
  PubSub
  Do
  ```
* Okay, these two are actually a bit mind-bendy.
  I've had to hold my head in my hands, to mitigate the pain,
  as I taught my brain to think in this way.

  Always go for the mind-fuck!

  ```ruby
  block_and_forth(&block)
  block_and_forth_forever(&block)
  ```
