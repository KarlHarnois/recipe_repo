require 'rails_helper'

RSpec.describe 'Recipe Index' do
  before do
    create :recipe, name: 'Chimichurri'
    create :recipe, name: 'Gravlox'
  end

  scenario 'recipes are dispalyed' do
    visit recipes_path

    expect(page).to have_text 'Chimichurri'
    expect(page).to have_text 'Gravlox'
  end
end
