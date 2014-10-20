require 'spec_helper'

describe EasyTransilien::Trip do
  before(:each) do
  end

  it 'expect get some Trip s from a simple search' do
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare')
    expect(trips.first.is_a?(EasyTransilien::Trip)).to be_truthy
  end

  it 'expect accepts options[:at] and handle last at default_duration' do
    at = Time.now
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {at: at})
    expect(trips.first.at).to eql(at)
    expect(trips.first.last).to eql(at + 3600)
  end

  it 'expect accepts options[:at] AND options[:last] at the same time' do
    at   = Time.now
    last = Time.now + 3600 * 2 + 42 # arbitrary…
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {at: at, last: last})
    expect(trips.first.at).to eql(at)
    expect(trips.first.last).to eql(last)
  end

  it 'expect auto sort when at is after last' do
    last = Time.now
    at   = Time.now + 3600 * 2 + 42 # arbitrary…
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {at: at, last: last})
    expect(trips.first.at).to eql(last)
    expect(trips.first.last).to eql(at)
  end

  it 'expect autoset at and last for options[:whole_day]' do
    hoy = Time.new
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {whole_day: true})
    expect(trips.first.at).to eql(Time.new(hoy.year, hoy.month, hoy.day, 0, 0, 1))
  end

  it 'expect ignore options :at and :last when :whole_day is set' do
    hoy = Time.new
    at   = Time.now
    last = Time.now + 3600 * 2 + 42 # arbitrary…
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {whole_day: true, at: at, last: last})
    expect(trips.first.at).to eql(Time.new(hoy.year, hoy.month, hoy.day, 0, 0, 1))
  end
end
