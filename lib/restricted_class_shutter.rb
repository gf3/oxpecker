require 'common'

# RestrictedClassShutter prevents javascript from accessing java classes and
# methods, effectively sandboxing the code.

class RestrictedClassShutter
  include org.mozilla.javascript.ClassShutter
  
  # Disallow access to *all* classes - because I don't trust you.
  
  def visibleToScripts(class_name)
    false
  end
  
end
