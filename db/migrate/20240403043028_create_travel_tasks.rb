class CreateTravelTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :travel_tasks do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :contents, null: false
      t.time :time
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
