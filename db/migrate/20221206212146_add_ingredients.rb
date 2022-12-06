class AddIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.belongs_to :version
      t.timestamps
    end
  end
end
