require 'rails_helper'

RSpec.describe Unit do
  describe 'db seeds' do
    let(:expected) do
      [
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

    it 'includes the correct units' do
      expect(described_class.pluck(:name, :abbreviation)).to match expected
    end
  end

  describe '#ingredients' do
    let(:ingredients) { build_list :ingredient, 3 }

    before do
      subject.ingredients = ingredients
    end

    it 'has many' do
      expect(subject.ingredients).to eq ingredients
    end
  end

  describe '.imperial' do
    let(:expected) do
      [
        'teaspoon',
        'tablespoon',
        'fluid ounce',
        'cup',
        'pint',
        'gallon',
        'pound',
        'ounce',
        'inch'
      ]
    end

    it 'returns the correct units' do
      expect(described_class.imperial.pluck(:name)).to match expected
    end
  end

  describe '.metric' do
    let(:expected) do
      %w[
        milliliter
        liter
        milligram
        gram
        kilogram
        millimeter
        centimeter
        meter
      ]
    end

    it 'returns the correct units' do
      expect(described_class.metric.pluck(:name)).to match expected
    end
  end

  describe '.volume' do
    let(:expected) do
      [
        'milliliter',
        'liter',
        'teaspoon',
        'tablespoon',
        'fluid ounce',
        'cup',
        'pint',
        'gallon'
      ]
    end

    it 'returns the correct units' do
      expect(described_class.volume.pluck(:name)).to match expected
    end
  end

  describe 'imperial?' do
    context 'when unit is imperial' do
      let(:unit) { build :unit, name: 'cup' }

      it 'is true' do
        expect(unit.imperial?).to be true
      end
    end

    context 'when unit is metric' do
      let(:unit) { build :unit, name: 'centimeter' }

      it 'is false' do
        expect(unit.imperial?).to be false
      end
    end
  end

  describe 'metric?' do
    context 'when unit is imperial' do
      let(:unit) { build :unit, name: 'cup' }

      it 'is false' do
        expect(unit.metric?).to be false
      end
    end

    context 'when unit is metric' do
      let(:unit) { build :unit, name: 'centimeter' }

      it 'is true' do
        expect(unit.metric?).to be true
      end
    end
  end

  describe '#volume?' do
    context 'when unit is volume' do
      let(:unit) { build :unit, name: 'teaspoon' }

      it 'is true' do
        expect(unit.volume?).to eq true
      end
    end

    context 'when unit is length' do
      let(:unit) { build :unit, name: 'inch' }

      it 'is false' do
        expect(unit.volume?).to eq false
      end
    end

    context 'when unit is weight' do
      let(:unit) { build :unit, name: 'gram' }

      it 'is false' do
        expect(unit.volume?).to eq false
      end
    end
  end
end
