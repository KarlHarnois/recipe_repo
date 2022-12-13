class IngredientPresenter
  def initialize(ingredient)
    @ingredient = ingredient
    @name_presenter = IngredientNamePresenter.new(ingredient)
  end

  def name_with_quantity
    "#{quantity} #{name_presenter.downcase_name}"
  end

  private

  attr_reader :ingredient, :name_presenter

  def quantity
    qty = ingredient.quantity
    decimal_quantity? ? qty : qty.to_i
  end

  def decimal_quantity?
    ingredient.quantity % 1 != 0
  end
end
