class Unit < ApplicationRecord
  has_many :ingredients

  scope :imperial, -> { where(name: IMPERIAL_UNITS) }
  scope :metric, -> { where(name: METRIC_UNITS) }
  scope :volume, -> { where(name: VOLUME_UNITS) }

  IMPERIAL_UNITS = [
    'teaspoon',
    'tablespoon',
    'fluid ounce',
    'cup',
    'pint',
    'gallon',
    'pound',
    'ounce',
    'inch'
  ].freeze

  METRIC_UNITS = %w[
    milliliter
    liter
    milligram
    gram
    kilogram
    millimeter
    centimeter
    meter
  ].freeze

  VOLUME_UNITS = [
    'milliliter',
    'liter',
    'teaspoon',
    'tablespoon',
    'fluid ounce',
    'cup',
    'pint',
    'gallon'
  ].freeze

  def imperial?
    IMPERIAL_UNITS.include?(name)
  end

  def metric?
    METRIC_UNITS.include?(name)
  end

  def volume?
    VOLUME_UNITS.include?(name)
  end
end
