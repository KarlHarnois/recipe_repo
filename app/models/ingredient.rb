class Ingredient < ApplicationRecord
  belongs_to :recipe_version
  belongs_to :product
  delegate :name, to: :product
  alias_attribute :version, :recipe_version
end
