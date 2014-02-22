CommaParty
======
CommaParty is a Ruby implementation of Clojure's
[Hiccup](https://github.com/weavejester/hiccup/) HTML generation library.
It uses arrays to represent elements, and hashes to represent an element's
attributes. Unlike in Clojure, you have to use a lot of commas everywhere all
the time.

Install
-------
Add the following dependency to your `Gemfile`:

```ruby
gem 'commaparty'
```

then

```ruby
require 'commaparty'
```

Syntax
------

Here is a basic example of commaparty syntax:

```ruby
[1] pry(main)> require 'commaparty'
=> true
[2] pry(main)> CommaParty.markup([:span, {class: "foo"}, "bar"])
=> "<span class=\"foo\">bar</span>"
```

The first element of the array is used as the element name. The second
attribute can optionally be a hash, in which case it is used to supply
the element's attributes. Every other element is considered part of the
tag's body.

It provides a CSS-like shortcut for denoting `id` and `class`
attributes:

```ruby
[1] pry(main)> CommaParty.markup([:'div#foo.bar.baz', "bang"])
=> "<div class=\"bar baz\" id=\"foo\">bang</div>"
```
