require 'rails_helper'

RSpec.describe 'Recipe Requests' do
  describe '#index' do
    let(:body) { JSON.parse(response.body) }

    before do
      create :recipe, name: 'Test 1'
      create :recipe, name: 'Test 2'

      get '/recipes.json'
    end

    it 'returns the correct response' do
      aggregate_failures do
        expect(body.count).to eq 2
        expect(body[0]['name']).to eq 'Test 1'
        expect(body[1]['name']).to eq 'Test 2'
      end
    end
  end
end
