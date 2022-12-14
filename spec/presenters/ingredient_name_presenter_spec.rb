require 'rails_helper'

RSpec.describe IngredientNamePresenter do
  describe '#downcase_name' do
    subject { described_class.new(ingredient).downcase_name }

    let(:ingredient) { build :ingredient, product: product, quantity: quantity }
    let(:product) { build :product, name: name }
    let(:name) { 'garlic' }
    let(:quantity) { 1 }

    context 'when name is uppercased' do
      let(:name) { 'Apple' }

      it 'lowercases the name' do
        expect(subject).to eq 'apple'
      end
    end

    context 'when quantities is under one' do
      let(:quantity) { 0.5 }

      it 'is singular' do
        expect(subject).to eq 'garlic'
      end
    end

    context 'when quantity is one' do
      it 'is singular' do
        expect(subject).to eq 'garlic'
      end
    end

    context 'when quantity is above one' do
      let(:quantity) { 5 }

      it 'is plural' do
        expect(subject).to eq 'garlics'
      end
    end
  end
end
