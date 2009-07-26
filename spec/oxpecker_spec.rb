require 'spec_helper'
require 'oxpecker'

describe Oxpecker do
  
  it "should implement a print method that can be accessed as a javascript function" do
    pending
    @o.evaluate("print('hey'); ' there'").should == "hey there"
  end
  
  describe "#evaluate" do
    before(:each) do
      @o = Oxpecker.new
    end
    
    after(:each) do
      @o.close
    end
    
    it "should evaluate simple js statements" do
      @o.evaluate("1 + 1").should == 2
    end
    
    it "should evaluate multiple js statements on one line" do
      @o.evaluate("function hi(name){ return 'Hi, '+name; }; var sentence = hi('James')+'!'; sentence").should == "Hi, James!"
    end
    
    it "should raise an exception if there is a syntax error in the javascript" do
      lambda{ @o.evaluate("var a = 'hi;") }.should raise_error(JavaScriptSyntaxError)
    end
    
    it "should raise an exception if there is an actual ecma error" do
      lambda{ @o.evaluate("poop('hi');") }.should raise_error(JavaScriptEcmaError, /ReferenceError/)
    end
    
    it "should raise an exception if an attempt to access a java class is made (LiveConnect)" do
      lambda{ @o.evaluate("java.lang.System.out.println(3)") }.should raise_error(JavaScriptEcmaError, /TypeError/)
    end
    
    it "should raise an exception if execution takes too long" do
      lambda{ @o.evaluate("var i=0; while(true) i++;") }.should raise_error(JavaScriptTimeoutError)
    end
  end
  
  describe "#close" do
    it "should exit the current context" do
      o = Oxpecker.new
      o.context.class.should_receive(:exit)
      o.close
    end
  end
end