$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'vendor')

# Constants
TIMEOUT = 1

# Requirements
require 'java'
require 'js.jar'

include Java

# Exceptions
class JavaScriptSyntaxError < Exception; end
class JavaScriptEcmaError < Exception; end
class JavaScriptTimeoutError < Exception; end