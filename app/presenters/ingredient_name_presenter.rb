class IngredientNamePresenter
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def downcase_name
    return base_name unless multiple?

    base_name.pluralize
  end

  private

  attr_reader :ingredient

  def multiple?
    ingredient.quantity > 1
  end

  def base_name
    ingredient.name.downcase
  end
end
