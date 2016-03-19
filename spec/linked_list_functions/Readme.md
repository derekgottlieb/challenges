Linked List Functions
=====================

In Ruby, a "function" is a method that only works on its arguments.


Purpose
-------

To work with and become familiar with a common structure for a linked list.
If you move onto the other ones without doing this, you have to figure
out this structure with many other unknowns all at the same time.
So do this one first, you'll be given a pre-built linked list to work with.
Later you can move on to the harder problems.


To run
------

Each function has its own file to test that it works.
Find the file for the one you want to try and run it like this:

```sh
$ mrspec spec/linked_list_functions/list_first_spec.rb
```


Suggestions
-----------

* Familiarize yourself with what a linked list is, first.
  Don't go to too much effort, just a general sense of how
  they work, and why we name them this.
* **GAIN CONTEXT** (seriously)
  * Think about what each one's name means
  * Guess what it probably does
  * Read the test names to see if you are right
  * Think about what you probably need to do before you attempt it


Suggested Order
---------------

Start with these:

```ruby
list_first(list)
list_shift(list)
list_unshift(list, data)
```

These are intermediate:

```ruby
list_size(list)
list_last(list)
list_min(list)
list_max(list)
```

These ones are harder:

```
list_at(list, index)
list_join(list, delimiter="")
list_insert(list, index, data)
```
