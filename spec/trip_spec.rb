require 'spec_helper'

describe EasyTransilien::Trip do
  it 'should get some Trip s from a simple search' do
    trips = EasyTransilien::Trip.find('val d\'argenteuil', 'paris saint-lazare')
    trips.first.is_a?(EasyTransilien::Trip).should be_true
  end
end
