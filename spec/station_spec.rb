# frozen_string_literal: true

require 'station'

describe Station do
  context 'When initialized' do
    it 'has a name' do
      station = Station.new(name: "name", zone: 1)
      expect(station.name).to eq "name"
    end

    it 'has a zone' do
      station = Station.new(name: "name", zone: 1)
      expect(station.zone).to eq 1
    end
  end
end
