class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.string :title, null: false
      t.text :contents, null: false
      t.date :date
      t.boolean :status,default: true
      t.timestamps
    end
  end
end
