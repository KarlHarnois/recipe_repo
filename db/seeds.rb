unit_names_and_abbreviations = [
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

Unit.destroy_all

unit_names_and_abbreviations.each do |name, abbreviation|
  Unit.create!(name: name, abbreviation: abbreviation)
end
