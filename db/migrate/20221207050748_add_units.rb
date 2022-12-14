class AddUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.string :abbreviation, null: false
    end
  end
end
