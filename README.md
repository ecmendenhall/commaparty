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

If the body of the element is an array, its contents will be expanded out
into the element body. This makes working with methods like `map` more
convenient:


```ruby
[2] pry(main)> CommaParty.markup([:ul, (1..4).map {|n| [:li, n]}])
=> "<ul>\n<li>1</li>\n<li>2</li>\n<li>3</li>\n<li>4</li>\n</ul>"
```
