require 'rails_helper'

RSpec.describe RecipeVersion do
  describe '#recipe' do
    let(:version) { build :recipe_version, recipe: recipe }
    let(:recipe) { build :recipe }

    it 'can be associated' do
      expect(version.recipe).to eq recipe
    end
  end
end
