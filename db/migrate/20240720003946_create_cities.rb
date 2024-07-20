class CreateCities < ActiveRecord::Migration[7.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :zip_code

      t.timestamps
    end
    add_index :cities, :zip_code, unique: true
  end
end
