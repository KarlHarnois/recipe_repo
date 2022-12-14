class ImperialUnitPresenter < UnitPresenter
  def unit_with_quantity
    "#{display_quantity} #{unit_name}"
  end

  private

  def display_quantity
    decimal_quantity? ? ratio_quantity : quantity.to_i
  end

  def ratio_quantity
    quantity.to_r.rationalize(0.05)
  end
end
