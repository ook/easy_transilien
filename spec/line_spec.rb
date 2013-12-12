require 'spec_helper'

describe EasyTransilien::Line do
  before(:each) do
    @line = EasyTransilien::Line.find('laz')
  end

  it 'should get some Line when searching for laz' do
    @line.is_a?(Array).should be_true
    @line.first.is_a?(EasyTransilien::Line).should be_true
    @line.length.should eql(1)
  end

  it 'should have at least one codes' do
    @line.codes.is_a?(Array).should be_true
    @line.codes.empty?.should be_false
  end
end
