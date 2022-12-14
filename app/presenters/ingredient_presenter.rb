class IngredientPresenter
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def name_with_quantity
    "#{unit_with_quantity} #{downcase_name}"
  end

  private

  attr_reader :ingredient

  def unit_with_quantity
    presenter = UnitPresenterFactory.presenter_for(ingredient)
    presenter.unit_with_quantity
  end

  def downcase_name
    presenter = IngredientNamePresenter.new(ingredient)
    presenter.downcase_name
  end
end
