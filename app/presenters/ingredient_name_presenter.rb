class IngredientNamePresenter
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def downcase_name
    return base_name unless multiple?
    return base_name if volume?

    base_name.pluralize
  end

  private

  attr_reader :ingredient

  delegate :unit, to: :ingredient

  def multiple?
    ingredient.quantity > 1
  end

  def volume?
    unit&.volume?
  end

  def base_name
    ingredient.name.downcase
  end
end
