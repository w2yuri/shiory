class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.timestamps
    end
  end
end
