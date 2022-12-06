require 'rails_helper'

RSpec.describe 'Recipe Requests' do
  let(:body) { JSON.parse(response.body) }

  describe '#index' do
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

  describe '#show' do
    let(:recipe) { create :recipe, name: 'Pizza' }

    before do
      get "/recipes/#{recipe.id}.json"
    end

    it 'returns the recipe' do
      expect(body['name']).to eq 'Pizza'
    end
  end
end
