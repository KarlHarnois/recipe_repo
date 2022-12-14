class MetricUnitPresenter < UnitPresenter
  def unit_with_quantity
    qty = decimal_quantity? ? quantity : quantity.to_i
    "#{qty} #{unit.abbreviation}"
  end
end
