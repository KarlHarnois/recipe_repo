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
    before do
      unit = Unit.find_by(name: 'gram')

      product = build :product, name: 'Pepperoni'
      ingredient = build :ingredient, product: product, notes: 'Some notes', unit: unit, quantity: 100
      version = build :recipe_version, ingredients: [ingredient]
      recipe = create :recipe, name: 'Pizza', versions: [version]

      get "/recipes/#{recipe.id}.json"
    end

    it 'returns the recipe' do
      expect(body['name']).to eq 'Pizza'
    end

    it 'returns the versions' do
      aggregate_failures do
        expect(body['versions'].count).to eq 1
        expect(body['current_version']).not_to be_nil
      end
    end

    it 'returns the correct amount of ingredients' do
      aggregate_failures do
        expect(body['versions'][0]['ingredients'].count).to eq 1
        expect(body['current_version']['ingredients'].count).to eq 1
      end
    end

    describe 'ingredient' do
      let(:ingredient) { body['current_version']['ingredients'][0] }

      it 'returns the name' do
        expect(ingredient['name']).to eq 'Pepperoni'
      end

      it 'returns the unit' do
        expect(ingredient['unit']).to eq 'gram'
      end

      it 'returns the quantity' do
        expect(ingredient['quantity']).to eq '100.0'
      end

      it 'returns the notes' do
        expect(ingredient['notes']).to eq 'Some notes'
      end
    end
  end
end
