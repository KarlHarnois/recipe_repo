class AddNotesToIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :notes, :string
  end
end
