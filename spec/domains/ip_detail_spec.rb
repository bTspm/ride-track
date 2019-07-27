require 'spec_helper'

describe Domains::IpDetail do

  let(:address) { double }
  let(:as) { double }
  let(:query) { double }
  let(:isp) { double }
  let(:org) { double }
  let(:timezone) { double }

  let(:response) do
    {
      as: as,
      query: query,
      isp: isp,
      org: org,
      timezone: timezone,
    }
  end

  subject(:ip_detail) { described_class.new(response) }

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        expect(Domains::Address).to receive(:new) { address }

        result = ip_detail
        expect(result).to be_kind_of Domains::IpDetail
        expect(result.address).to eq address
        expect(result.as).to eq as
        expect(result.ip).to eq query
        expect(result.isp).to eq isp
        expect(result.organization).to eq org
        expect(result.timezone).to eq timezone
      end
    end

    context 'address' do
      subject { ip_detail.address }
      context 'no response' do
        let(:response) { {} }
        it { is_expected.to be_nil }
      end
    end
  end
end

