require 'spec_helper'

MS_STOP_PAYLOAD = "<Stop StopIdx=\"3856503\" StopPointIdx=\"37162\" VehicleJourneyIdx=\"326541\" HourNumber=\"0\" MinuteNumber=\"0\" DestinationPos=\"-1\" ODTIdx=\"0\" ODTPos=\"-1\" ValidityPatternSetCommentPos=\"0\" StopOrder=\"9\" VehicleIdx=\"0\">\n  <StopTime>\n    <TotalSeconds>52800</TotalSeconds>\n    <Day>0</Day>\n    <Hour>14</Hour>\n    <Minute>40</Minute>\n  </StopTime>\n  <StopArrivalTime>\n    <TotalSeconds>52740</TotalSeconds>\n    <Day>0</Day>\n    <Hour>14</Hour>\n    <Minute>39</Minute>\n  </StopArrivalTime>\n  <StopPoint StopPointIdx=\"37162\" StopPointId=\"39732\" StopPointName=\"VAL D'ARGENTEUIL\" StopPointExternalCode=\"DUA8738179\" FareZone=\"4\">\n    <StopPointAddress StopPointAddressName=\"\" StopPointAddressNumber=\"\" StopPointAddressTypeName=\"\"/>\n    <Equipment Sheltered=\"False\" MIPAccess=\"False\" Elevator=\"False\" Escalator=\"False\" BikeAccepted=\"False\" BikeDepot=\"False\"/>\n    <Mode ModeIdx=\"3\" ModeId=\"3\" ModeName=\"BUS\" ModeExternalCode=\"RATP\" ModeTypeExternalCode=\"Bus\"/>\n    <City CityIdx=\"1102\" CityId=\"1101\" CityName=\"Argenteuil\" CityExternalCode=\"95018\" CityCode=\"95100\"/>\n    <StopArea StopAreaIdx=\"15924\" StopAreaId=\"16639\" StopAreaName=\"VAL D'ARGENTEUIL\" StopAreaExternalCode=\"DUA8738179\" MainStopArea=\"1\" MultiModal=\"0\" CarPark=\"0\" MainConnection=\"0\" AdditionalData=\"\" ResaRailCode=\"\">\n      <Coord>\n        <CoordX>592262,31</CoordX>\n        <CoordY>2439172,77</CoordY>\n      </Coord>\n    </StopArea>\n    <Coord>\n      <CoordX>592274,51</CoordX>\n      <CoordY>2439127,18</CoordY>\n    </Coord>\n  </StopPoint>\n</Stop>"

Noko_Payload = Nokogiri.XML(MS_STOP_PAYLOAD)

describe EasyTransilien::Stop do
  it 'should get valid #time from ms_stop' do
    time = Time.new
    ms_stop = Transilien::Stop.from_node(Noko_Payload, time)

    es = EasyTransilien::Stop.new
    es.ms_stop =  ms_stop
    es.is_a?(EasyTransilien::Stop).should be_true
    es.time.is_a?(Time).should be_true
    es.time.should eql(Time.local(2013,11,18,14,40))
  end
end
