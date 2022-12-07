class IngredientPresenter
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def name_with_quantity
    "#{quantity} #{ingredient.name}"
  end

  private

  attr_reader :ingredient

  def quantity
    qty = ingredient.quantity
    decimal_quantity? ? qty : qty.to_i
  end

  def decimal_quantity?
    ingredient.quantity % 1 != 0
  end
end
