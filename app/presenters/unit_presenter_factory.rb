class UnitPresenterFactory
  def self.presenter_for(ingredient)
    new(ingredient).presenter
  end

  def presenter
    presenter_class.new(ingredient)
  end

  private

  attr_reader :ingredient

  delegate :unit, to: :ingredient

  def initialize(ingredient)
    @ingredient = ingredient
  end

  def presenter_class
    return NullUnitPresenter if unit.nil?

    unit.imperial? ? ImperialUnitPresenter : MetricUnitPresenter
  end
end
