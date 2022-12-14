require 'rails_helper'

RSpec.describe IngredientPresenter do
  subject { described_class.new(ingredient) }

  describe '#name_with_quantity' do
    let(:product) { build :product, name: 'Banana' }
    let(:quantity) { 0 }
    let(:unit) { nil }

    let(:ingredient) do
      build :ingredient, product: product,
                         quantity: quantity,
                         unit: unit
    end

    context 'when quantity has no decimals' do
      let(:quantity) { 3 }

      it 'drops the decimals' do
        expect(subject.name_with_quantity).to eq '3 bananas'
      end
    end

    context 'when unit is metric' do
      let(:unit) { build :unit, name: 'milliliter', abbreviation: 'ml' }
      let(:product) { build :product, name: 'Milk' }
      let(:quantity) { 11.5 }

      it 'uses decimals' do
        expect(subject.name_with_quantity).to eq '11.5 ml milk'
      end
    end
  end
end
