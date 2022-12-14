class UnitPresenter
  def initialize(ingredient)
    @quantity = ingredient.quantity
    @unit = ingredient.unit
  end

  def unit_with_quantity
    raise NotImplementedError
  end

  private

  attr_reader :quantity, :unit

  def unit_name
    base = unit.name
    quantity > 1 ? base.pluralize : base
  end

  def decimal_quantity?
    quantity % 1 != 0
  end
end
