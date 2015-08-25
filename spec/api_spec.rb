require 'json'

require File.expand_path(File.join(%w(.. support api)), __FILE__)

describe API do

  pending 'POST sessions'

  pending 'POST uploads'

  context 'GET talks' do

    let(:response) { API.get('/talks?limit=1') }

    it 'should respond with success' do
      expect(response.code).to eq(200)
    end

    it 'should respond with well formed json' do
      data = JSON.parse(response.body)
      expect(data).to be_an(Array)
    end

    it 'should respond with one element' do
      data = JSON.parse(response.body)
      expect(data.size).to eq(1)
    end

    it 'should have all documented fields' do
      data = JSON.parse(response.body)
      expect(API::TALK_FIELDS - data.first.keys).to be_empty
    end

    it 'should not have any undocumented fields' do
      data = JSON.parse(response.body)
      expect(data.first.keys - API::TALK_FIELDS).to be_empty
    end

  end
end
