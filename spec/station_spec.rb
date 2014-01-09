require 'spec_helper'

describe EasyTransilien::Station do
  it 'should get some Station when searching for argenteuil' do
    col = EasyTransilien::Station.find('argenteuil')
    col.is_a?(Array).should be_true
    col.first.is_a?(EasyTransilien::Station).should be_true
    col.length.should eql(2)
  end
  it 'should get all Station for empty search' do
    col = EasyTransilien::Station.find
    col.is_a?(Array).should be_true
    (col.length > 0).should be_true
  end

  it 'should get at least a Line for a Station' do
    station = EasyTransilien::Station.find('Val d\'Argenteuil').first
    station.lines.is_a?(Array).should be_true
    (station.lines.length > 0).should be_true
    station.lines[0].is_a?(EasyTransilien::Line).should be_true
  end

  it 'should get at least one line_letters for a Station' do
    station = EasyTransilien::Station.find('Val d\'Argenteuil').first
    station.codes.is_a?(Array).should be_true
    (station.codes.length > 0).should be_true
    station.codes[0].is_a?(String).should be_true
    station.codes[0].should eql('J')
  end
end
