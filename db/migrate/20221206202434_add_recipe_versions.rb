class AddRecipeVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_versions do |t|
      t.belongs_to :recipe
      t.timestamps
    end
  end
end
