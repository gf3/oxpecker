Oxpecker
========

Sandboxed javascript from ruby.
**Note:** This is still _super alpha_, so don't complain.

Cool
----

I know, right? Anyway, Oxpecker is basically an interface to Mozilla's
[Rhino](http://www.mozilla.org/rhino/) with some security precautions set in
place. Oxpecker also cleans up some of the Java exceptions and return values,
and makes them a bit more ruby-friendly.

It's possible to do this natively in Ruby by using JRuby to interface with the
Java library.

Examples
--------

For one-off script execution use the 'evaluate' class method:

    Oxpecker.evaluate("1 + 1") # 2

Alternatively, you can create a new instance, and execute as much JS as you
please within the same scope:

    o = Oxpecker.new :source_name => "SexyScript"
    o.evaluate("function hi(name){ return 'Hi, '+name+'.'; }") # nil
    puts o.evaluate("hi('Fabio') + ' Nice to see you!'") # Hi, Fabio. Nice to see you!
    o.close


You should _always_ 'close' your Oxpecker instances when you're finished with them:

    o = Oxpecker.new
    begin
        o.evaluate "7 * 10"
    ensure
        o.close
    end

Todo
----

1. Write a print method and make it available to JavaScript.

Author
------

Written by [Gianni Chiappetta](http://github.com/giannichiappetta) &ndash; [Runlevel6](http://www.runlevel6.org/)