class ImperialUnitPresenter < UnitPresenter
  def unit_with_quantity
    "#{display_quantity} #{unit_name}"
  end

  private

  delegate :quantity, to: :ingredient

  def display_quantity
    decimals? ? ratio_quantity : quantity.to_i
  end

  def ratio_quantity
    quantity.to_r.rationalize(0.05)
  end

  def decimals?
    quantity % 1 != 0
  end

  def unit_name
    base = ingredient.unit.name
    quantity > 1 ? base.pluralize : base
  end
end
