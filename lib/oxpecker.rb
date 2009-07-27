#!/usr/bin/env jruby --1.9
# Execute sandboxed JavaScript from Ruby using Mozilla's Rhino.
#
# Author::    Gianni Chiappetta  (mailto:gianni@runlevel6.org)
# Copyright:: Copyright (c) 2009 Gianni Chiappetta
# License::   Distributes under the MIT license

require 'common'
require 'restricted_class_shutter'
require 'restricted_context_factory'

# Oxpecker is the little bird that sits on a rhino's back and eats parasites :)

class Oxpecker
  import 'org.mozilla.javascript'
  attr_accessor :context
  attr_accessor :scope
  org.mozilla.javascript.ContextFactory.initGlobal RestrictedContextFactory.new
  
  # Instantiate a new Oxpecker, creating a context and scope
  
  def initialize(options={})
    @options = {
      :source_name => "Anonymous"
    }.merge(options)
    @context = Context.enter
    @scope = context.initStandardObjects
    @context.setClassShutter(RestrictedClassShutter.new)
  end
  
  # Evaluate a string of javascript within the context and scope of this
  # instance. Also cleanup any java exceptions and convert to slightly less
  # hostile ruby exceptions.
  
  def evaluate(js="")
    val = @context.evaluateString(@scope, js, @options[:source_name], 1, nil)
    if val.is_a?(org.mozilla.javascript.Undefined)
      nil
    else
      val
    end
  rescue org.mozilla.javascript.EvaluatorException => e
    raise JavaScriptSyntaxError, e.message.gsub(/org\.mozilla\.javascript\.\w+: /, '')
  rescue org.mozilla.javascript.EcmaError => e
    raise JavaScriptEcmaError, e.message.gsub(/org\.mozilla\.javascript\.\w+: /, '')  
  end
  
  def close
    @context.class.exit
  end
  
  # Evaluate a one-off, arbitrary string of javascript
  
  def self.evaluate(js="")
    o = self.new
    o.evaluate(js)
  ensure
    o.close
  end
  
end

# Main
if $0 == __FILE__
  ARGV.each do |i|
    puts Oxpecker.evaluate(i)
  end
end