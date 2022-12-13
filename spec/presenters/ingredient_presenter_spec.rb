require 'rails_helper'

RSpec.describe IngredientPresenter do
  subject { described_class.new(ingredient) }

  describe '#name_with_quantity' do
    context 'when quantity has no decimals' do
      let(:ingredient) do
        build :ingredient, unit: nil,
                           quantity: 3,
                           product: build(:product, name: 'Banana')
      end

      it 'drops the decimals' do
        expect(subject.name_with_quantity).to eq '3 bananas'
      end
    end
  end
end
