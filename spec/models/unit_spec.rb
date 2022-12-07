require 'rails_helper'

RSpec.describe Unit do
  describe 'db seeds' do
    it 'includes the correct units' do
      expect(described_class.pluck(:name, :abbreviation)).to match [
        %w[milliliter ml],
        %w[liter l],
        %w[teaspoon tsp],
        %w[tablespoon tbsp],
        ['fluid ounce', 'fl oz'],
        %w[cup c],
        %w[pint pt],
        %w[gallon gal],
        %w[milligram mg],
        %w[gram g],
        %w[kilogram kg],
        %w[pound lb],
        %w[ounce oz],
        %w[millimeter mm],
        %w[centimeter cm],
        %w[meter m],
        %w[inch in]
      ]
    end
  end
end
