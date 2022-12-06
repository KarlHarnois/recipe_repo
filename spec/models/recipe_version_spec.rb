require 'rails_helper'

RSpec.describe RecipeVersion do
  describe '#recipe' do
    let(:recipe) { build :recipe }

    before do
      subject.recipe = recipe
    end

    it 'has one' do
      expect(subject.recipe).to eq recipe
    end
  end

  describe '#ingredients' do
    let(:ingredient) { build :ingredient }

    before do
      subject.ingredients << ingredient
    end

    it 'has many' do
      expect(subject.ingredients).to eq [ingredient]
    end
  end
end
