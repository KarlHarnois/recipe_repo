class NullUnitPresenter < UnitPresenter
  def unit_with_quantity
    qty = decimal_quantity? ? quantity : quantity.to_i
    qty.to_s
  end
end
