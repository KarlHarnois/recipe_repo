require 'rails_helper'

RSpec.describe 'Recipe Requests' do
  let(:body) { JSON.parse(response.body) }
  let(:recipes) { body['recipes'] }

  describe '#index' do
    before do
      create :recipe, name: 'Test 1'
      create :recipe, name: 'Test 2'

      get '/recipes.json'
    end

    it 'returns the correct response' do
      aggregate_failures do
        expect(recipes.count).to eq 2
        expect(recipes[0]['name']).to eq 'Test 1'
        expect(recipes[1]['name']).to eq 'Test 2'
      end
    end

    it 'does not include the versions' do
      aggregate_failures do
        expect(recipes[0]['current_version']).to be_nil
        expect(recipes[0]['versions']).to be_nil
      end
    end
  end

  describe '#show' do
    let(:recipe) { create :recipe, name: 'Pizza', versions: [version] }
    let(:version) { build :recipe_version, ingredients: [ingredient] }
    let(:ingredient) { build :ingredient, product: product }
    let(:product) { build :product, name: 'Pepperoni' }

    before do
      get "/recipes/#{recipe.id}.json"
    end

    it 'returns the recipe' do
      aggregate_failures do
        expect(body['name']).to eq 'Pizza'
        expect(body['versions'].count).to eq 1
        expect(body['versions'][0]['ingredients'].count).to eq 1
        expect(body['current_version']['ingredients'].count).to eq 1
        expect(body['current_version']['ingredients'][0]['name']).to eq 'Pepperoni'
      end
    end
  end
end
