class AddQuantityToIngredient < ActiveRecord::Migration[7.0]
  def change
    add_column :ingredients, :quantity, :decimal
  end
end
