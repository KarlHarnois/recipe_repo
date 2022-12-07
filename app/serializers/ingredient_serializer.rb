class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :notes, :quantity, :unit

  def unit
    object.unit&.name
  end
end
