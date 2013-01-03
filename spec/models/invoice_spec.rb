require File.dirname(__FILE__) + '/../spec_helper'

describe Invoice do
  it "should be valid" do
    Invoice.new.should be_valid
  end
end
