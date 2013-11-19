require 'spec_helper'

describe EasyTransilien::Station do
  it 'should get some Station when searching for argenteuil' do
    # This payload was generated from
    # http://ms.api.transilien.com/?action=VehicleJourneyList&RouteExternalCode=DUA8008540420003%3BDUA8008540430008%3BDUA8008540430010%3BDUA8008540430005%3BDUA8008544000030%3BDUA8008540440001|or&Date=2013|10|24&StartTime=18|19&EndTime=18|21
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
end
