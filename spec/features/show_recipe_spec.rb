require 'rails_helper'

RSpec.describe 'Show Recipe' do
  let(:recipe) { create :recipe, name: 'Greek Salad', versions: [version] }
  let(:version) { build :recipe_version, ingredients: ingredients }

  let(:ingredients) do
    [
      build(:ingredient, product: build(:product, name: 'Cucumber')),
      build(:ingredient, product: build(:product, name: 'Tomato')),
      build(:ingredient, product: build(:product, name: 'Feta'))
    ]
  end

  before do
    visit recipe_path(recipe)
  end

  it 'displays recipes' do
    aggregate_failures do
      expect(page).to have_text 'Cucumber'
      expect(page).to have_text 'Tomato'
      expect(page).to have_text 'Feta'
    end
  end
end
