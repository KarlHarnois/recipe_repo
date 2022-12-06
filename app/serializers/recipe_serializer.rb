class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :current_version
  has_many :versions
end
