require 'rails_helper'

RSpec.describe 'Recipe Index' do
  let!(:chimichurri) { create :recipe, name: 'Chimichurri' }
  let!(:gravlox) { create :recipe, name: 'Gravlox' }

  before do
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
      expect(current_path).to eq recipe_path(gravlox.id)
    end
  end
end
