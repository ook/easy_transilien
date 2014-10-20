require 'spec_helper'

describe EasyTransilien::Station do
  it 'expect get some Station when searching for argenteuil' do
    col = EasyTransilien::Station.find('argenteuil')
    expect(col.is_a?(Array)).to be_truthy
    expect(col.first.is_a?(EasyTransilien::Station)).to be_truthy
    expect(col.length).to eql(2)
  end
  it 'expect get all Station for empty search' do
    col = EasyTransilien::Station.find
    expect(col.is_a?(Array)).to be_truthy
    expect(col.length > 0).to be_truthy
  end

  it 'expect get at least a Line for a Station' do
    station = EasyTransilien::Station.find('Val d\'Argenteuil').first
    expect(station.lines.is_a?(Array)).to be_truthy
    expect(station.lines.length > 0).to be_truthy
    expect(station.lines[0].is_a?(EasyTransilien::Line)).to be_truthy
  end

  it 'expect get at least one line_letters for a Station' do
    station = EasyTransilien::Station.find('Val d\'Argenteuil').first
    expect(station.codes.is_a?(Array)).to be_truthy
    expect(station.codes.length > 0).to be_truthy
    expect(station.codes[0].is_a?(String)).to be_truthy
    expect(station.codes[0]).to eql('J')
  end
end
