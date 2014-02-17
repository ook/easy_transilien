require 'spec_helper'

describe EasyTransilien::Trip do
  before(:each) do
  end

  it 'should get some Trip s from a simple search' do
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare')
    trips.first.is_a?(EasyTransilien::Trip).should be_true
  end

  it 'should accepts options[:at] and handle last at default_duration' do
    at = Time.now
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {at: at})
    trips.first.at.should eql(at)
    trips.first.last.should eql(at + 3600)
  end

  it 'should accepts options[:at] AND options[:last] at the same time' do
    at   = Time.now
    last = Time.now + 3600 * 2 + 42 # arbitrary…
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {at: at, last: last})
    trips.first.at.should eql(at)
    trips.first.last.should eql(last)
  end

  it 'should auto sort when at is after last' do
    last = Time.now
    at   = Time.now + 3600 * 2 + 42 # arbitrary…
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {at: at, last: last})
    trips.first.at.should eql(last)
    trips.first.last.should eql(at)
  end

  it 'should autoset at and last for options[:whole_day]' do
    hoy = Time.new
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {whole_day: true})
    trips.first.at.should eql(Time.new(hoy.year, hoy.month, hoy.day, 0, 0, 1))
    trips.first.last.should eql(Time.new(hoy.year, hoy.month, (hoy.day + 1)) + 1)
  end

  it 'should ignore options :at and :last when :whole_day is set' do
    hoy = Time.new
    at   = Time.now
    last = Time.now + 3600 * 2 + 42 # arbitrary…
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare', {whole_day: true, at: at, last: last})
    trips.first.at.should eql(Time.new(hoy.year, hoy.month, hoy.day, 0, 0, 1))
    trips.first.last.should eql(Time.new(hoy.year, hoy.month, (hoy.day + 1)) + 1)
  end
end
