class UnitPresenterFactory
  def self.presenter_for(ingredient)
    new(ingredient).presenter
  end

  def presenter
    presenter_class.new(ingredient)
  end

  private

  attr_reader :ingredient

  def initialize(ingredient)
    @ingredient = ingredient
  end

  def presenter_class
    if ingredient.unit.nil?
      NullUnitPresenter
    else
      ImperialUnitPresenter
    end
  end
end
