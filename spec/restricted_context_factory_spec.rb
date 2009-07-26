require 'spec_helper'
require 'restricted_context_factory'

describe RestrictedContextFactory do
  it "should inherit from org.mozilla.javascript.ContextFactory" do
    RestrictedContextFactory.new.is_a?(org.mozilla.javascript.ContextFactory).should be_true
  end
end