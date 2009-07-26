require 'common'

class RestrictedContextFactory < org.mozilla.javascript.ContextFactory
  class RestrictedContext < org.mozilla.javascript.Context
    attr_accessor :start_time
  end
  
  protected
  
  # Return a RestrictedContext by default
  
  def makeContext
    context = RestrictedContext.new
    context.setInstructionObserverThreshold 1000
    context
  end
  
  # Executed every n instructions, raises an exception after TIMEOUT seconds
  
  def observeInstructionCount(context, instruction_count)
    raise(JavaScriptTimeoutError, "Execution killed after #{TIMEOUT} second(s)") if Time.now.to_f - context.start_time > TIMEOUT
  end
  
  # Set the start time and pass calls to the super class
  
  def doTopCall(callable, context, scope, thisObj, args)
    context.start_time = Time.now.to_f
    super(callable, context, scope, thisObj, args)
  end
  
end