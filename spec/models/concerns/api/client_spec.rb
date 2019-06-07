require 'spec_helper'

describe Api::Client do

  let(:url) {'URL'}
  let(:auth_type) {Api::Client::BASIC_AUTH}
  let(:auth_options) {{token: 'a'}}
  let(:headers) {{}}
  let(:request) {{request_type: 'POST'}}

  subject {Api::Client.new(url: url, auth_type: auth_type, auth_options: auth_options, headers: headers)}

  describe '#initialize' do
    context 'instance' do
      it 'should initialize client' do
        expect(subject).to be_kind_of Api::Client
      end
    end

    context 'auth types - BASIC' do
      let(:auth_type) {Api::Client::BASIC}
      it 'should initialize client' do
        expect(subject).to be_kind_of Api::Client
      end
    end

    context 'errors' do
      let(:auth_type) {'a'}
      it 'should raise an exception when auth_type is unknown' do
        expect {subject}.to raise_error Exceptions::AppExceptions::NoSelectionError
      end
    end

  end

  describe '_get' do
    let(:get_response) {build_get_response}
    before :each do
      allow_any_instance_of(Api::Client).to receive(:build_connection) {get_response}
    end
    context 'response success' do
      it 'should return response with success' do
        result = subject.get(url: 'get_url', cache_key: 'a', expire_time: 0)
        expect(result).to be_kind_of Api::Response
        expect(result.body).to eq({'test' => 'Success'})
        expect(result.success).to be true
        expect(result.headers).to eq({})
        expect(result.status).to eq 200
      end
    end

    context 'response failure' do
      let(:get_response) {build_get_response(test: 'failure')}
      it 'should return response with failure' do
        result = subject.get(url: 'get_url', cache_key: 'a', expire_time: 0)
        expect(result).to be_kind_of Api::Response
        expect(result.body).to eq({'test' => 'Failure'})
        expect(result.success).to be false
        expect(result.headers).to eq({})
        expect(result.status).to eq 400
      end
    end
  end

  describe '_post' do
    let(:post_response) {build_post_response(test: 'success')}
    before :each do
      allow_any_instance_of(Api::Client).to receive(:build_connection) {post_response}
    end
    context 'response success' do
      it 'should return response with success' do
        result = subject.post(url: 'post_url', cache_key: 'a', expire_time: 0, request: request)
        expect(result).to be_kind_of Api::Response
        expect(result.body).to eq({'test' => 'Success'})
        expect(result.success).to be true
        expect(result.headers).to eq({})
        expect(result.status).to eq 200
      end
    end

    context 'response failure' do
      let(:post_response) {build_post_response(test: 'failure')}
      it 'should return response with failure' do
        result = subject.post(url: 'post_url', cache_key: 'a', expire_time: 0, request: request)
        expect(result).to be_kind_of Api::Response
        expect(result.body).to eq({'test' => 'Failure'})
        expect(result.success).to be false
        expect(result.headers).to eq({})
        expect(result.status).to eq 400
      end
    end
  end

  private

  def build_get_response(test: 'success')
    status, response = status_and_response(test: test)
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get("get_url") { |env| [status, {}, response] }
    end
    faraday_builder stubs
  end

  def build_post_response(test: 'success')
    status, response = status_and_response(test: test)
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.post("post_url") { |env| [status, {}, response] }
    end
    faraday_builder stubs
  end

  def faraday_builder(stubs)
    Faraday.new do |builder|
      builder.adapter :test, stubs
    end
  end

  def status_and_response(test:)
    if test == 'success'
      status = 200
      response = {test: 'Success'}
    else
      status = 400
      response = {test: 'Failure'}
    end
    return status, response
  end

end