class UnitPresenterFactory
  def presenter_for(ingredient)
    ImperialUnitPresenter.new(ingredient)
  end
end
