require 'rails_helper'

RSpec.describe Ingredient do
  describe '#version' do
    let(:version) { build :recipe_version }

    before do
      subject.version = version
    end

    it 'has one' do
      expect(subject.version).to eq version
    end
  end

  describe '#product' do
    let(:product) { build :product }

    before do
      subject.product = product
    end

    it 'has one' do
      expect(subject.product).to eq product
    end
  end

  describe '#quantity' do
    before do
      subject.quantity = 0.5
    end

    it 'has one' do
      expect(subject.quantity).to eq 0.5
    end
  end

  describe '#unit' do
    let(:unit) { build :unit }

    before do
      subject.unit = unit
    end

    it 'has one' do
      expect(subject.unit).to eq unit
    end
  end

  describe '#notes' do
    before do
      subject.notes = 'test'
    end

    it 'has some' do
      expect(subject.notes).to eq 'test'
    end
  end
end
