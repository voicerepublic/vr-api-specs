require 'json'

require File.expand_path(File.join(%w(.. support api)), __FILE__)

describe API do

  context 'talks' do

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

    it 'should have the documented fields' do
      fields = %w( id
                   title
                   venue_id
                   starts_at
                   ends_at
                   ended_at
                   collect
                   created_at
                   updated_at
                   teaser
                   description
                   duration
                   image_uid
                   featured_from
                   state
                   started_at
                   processed_at
                   play_count
                   starts_at_date
                   starts_at_time
                   uri
                   recording_override
                   related_talk_id
                   grade
                   language
                   slug
                   format
                   speakers )
      data = JSON.parse(response.body)
      expect(data.first.keys - fields).to be_empty
      expect(fields - data.first.keys).to be_empty
    end

  end

end
