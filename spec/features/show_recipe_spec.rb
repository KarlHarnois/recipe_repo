require 'rails_helper'

RSpec.describe 'Show Recipe' do
  let(:recipe) { create :recipe, name: 'Greek Salad', versions: [version] }
  let(:version) { build :recipe_version, ingredients: ingredients }

  let(:ingredients) do
    [
      build(:ingredient, quantity: 1, product: build(:product, name: 'Cucumber')),
      build(:ingredient, quantity: 2.5, product: build(:product, name: 'Tomato')),
      build(:ingredient, quantity: 10, product: build(:product, name: 'Feta'))
    ]
  end

  before do
    visit recipe_path(recipe)
  end

  it 'displays recipes' do
    aggregate_failures do
      expect(page).to have_text '1 cucumber'
      expect(page).to have_text '2.5 tomatoes'
      expect(page).to have_text '10 feta'
    end
  end
end
