class CreateTravelTaskComments < ActiveRecord::Migration[6.1]
  def change
    create_table :travel_task_comments do |t|
      t.integer :customer_id, null: false
      t.integer :travel_task_id, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
