class Ingredient < ApplicationRecord
  belongs_to :version, class_name: RecipeVersion.to_s
end
