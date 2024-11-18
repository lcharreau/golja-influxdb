require 'spec_helper'
require 'facter'
require 'facter/influxdb_version'

describe Facter::Util::Fact do
  before { Facter.clear }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      describe 'when influxdb present' do
        it 'expect Facter[:influxdb_version].value == "1.2.0"' do
          influxdb_output = '1.2.0'

          # Mock the calls to Facter::Util::Resolution
          allow(Facter::Util::Resolution).to receive(:which).with('influx').and_return(true)
          allow(Facter::Util::Resolution).to receive(:exec).with('influx --version').and_return(influxdb_output)

          # now we assert what we expect for our custom fact.
          expect(Facter[:influxdb_version].value).to eq '1.2.0'
        end
      end

      describe 'when influxdb not present' do
        it 'expect Facter[:influxdb_version].value == nil' do
          expect(Facter[:influxdb_version].value).to eq nil
        end
      end
    end
  end
end
