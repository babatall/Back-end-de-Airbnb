class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :phone_number
      t.text :description

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
