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
end
