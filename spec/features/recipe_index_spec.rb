require 'rails_helper'

RSpec.describe 'Recipe Index' do
  let!(:gravlox) { create :recipe, name: 'Gravlox' }

  before do
    create :recipe, name: 'Chimichurri'

    visit recipes_path
  end

  it 'displays recipes' do
    aggregate_failures do
      expect(page).to have_text 'Chimichurri'
      expect(page).to have_text 'Gravlox'
    end
  end

  it 'links to the recipe details' do
    click_link 'Gravlox'

    aggregate_failures do
      expect(page).to have_current_path recipe_path(gravlox.id)
      expect(page).to have_text 'Gravlox'
    end
  end
end
