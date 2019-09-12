require 'spec_helper'

describe IpHelper do

  describe '#fraud_score_format' do
    let(:options) { {} }
    subject { fraud_score_format(options) }

    it 'should contain score classes' do
      expect(subject).to include 'badge badge-pill badge-info'
    end
  end

  describe '#quality_detail_format' do
    let(:left_border_class) { 'Left Border Class' }
    let(:options) { {left_border_class: left_border_class} }

    subject { quality_detail_format(options) }

    context 'default properties' do
      it 'should include default class' do
        expect(subject).not_to include 'info-left'
        expect(subject).to include 'Left Border Class'
      end
    end

    context 'provided properties' do
      let(:left_border_class) { nil }

      it 'should include provided class' do
        expect(subject).to include 'info-left'
      end
    end
  end
end

