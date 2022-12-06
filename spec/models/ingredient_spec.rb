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
end
