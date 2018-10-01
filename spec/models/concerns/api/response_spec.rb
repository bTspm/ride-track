require 'spec_helper'

describe Api::Response do

  let(:body) {{}}
  let(:status) {'Status'}
  let(:headers) {'Headers'}
  let(:success) {'Success'}
  subject {Api::Response.new(body: body, status: status, headers: headers, success: success)}

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = subject
        expect(result).to be_kind_of Api::Response
        expect(result.body).to eq({})
        expect(result.status).to eq 'Status'
        expect(result.headers).to eq 'Headers'
        expect(result.success).to eq 'Success'
      end
    end
  end

end