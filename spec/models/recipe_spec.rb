require 'rails_helper'

RSpec.describe Recipe do
  describe '#name' do
    let(:recipe) { create :recipe, name: 'Test' }

    it 'has a name' do
      expect(recipe.name).to eq 'Test'
    end
  end
end
