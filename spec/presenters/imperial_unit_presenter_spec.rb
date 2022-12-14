require 'rails_helper'

RSpec.describe ImperialUnitPresenter do
  describe '#unit_with_quantity' do
    subject { described_class.new(ingredient).unit_with_quantity }

    let(:ingredient) { build :ingredient, unit: unit, quantity: quantity }
    let(:unit) { build :unit, name: 'cup' }
    let(:quantity) { 1 }

    context 'when quantity has decimals' do
      let(:quantity) { 0.333333 }

      it 'uses fractions' do
        expect(subject).to eq '1/3 cup'
      end
    end

    context 'when quantity above 1' do
      let(:unit) { build :unit, name: 'gallon' }
      let(:quantity) { 4 }

      it 'pluralizes the name' do
        expect(subject).to eq '4 gallons'
      end
    end
  end
end
