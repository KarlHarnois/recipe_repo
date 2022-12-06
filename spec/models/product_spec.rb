require 'rails_helper'

RSpec.describe Product do
  describe '#ingredients' do
    let(:ingredients) { build_list :ingredient, 3 }

    before do
      subject.ingredients = ingredients
    end

    it 'has many' do
      expect(subject.ingredients).to eq ingredients
    end
  end
end
