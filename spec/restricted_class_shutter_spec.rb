require 'spec_helper'
require 'restricted_class_shutter'

describe RestrictedClassShutter do
  
  it "should disallow access to all classes" do
    rcs = RestrictedClassShutter.new
    rcs.visibleToScripts("Class").should be_false
    rcs.visibleToScripts("System").should be_false
    rcs.visibleToScripts("String").should be_false
  end
  
end