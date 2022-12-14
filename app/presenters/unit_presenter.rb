class UnitPresenter
  def initialize(ingredient)
    @ingredient = ingredient
  end

  def unit_with_quantity
    raise NotImplementedError
  end

  private

  attr_reader :ingredient
end
