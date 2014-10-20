require 'spec_helper'

describe EasyTransilien::Line do
  before(:each) do
    @line = EasyTransilien::Line.find('laz').first
  end

  it 'expect get some Line when searching for laz' do
    expect(@line.is_a?(EasyTransilien::Line)).to be_truthy
  end

  it 'expect have at least one codes' do
    expect(@line.codes.is_a?(Array)).to be_truthy
    expect(@line.codes.empty?).to be_falsey
  end
end
