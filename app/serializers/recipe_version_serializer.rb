class RecipeVersionSerializer < ActiveModel::Serializer
  attributes :id, :created_at
  has_many :ingredients
end
