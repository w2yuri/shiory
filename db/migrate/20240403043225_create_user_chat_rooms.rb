class CreateUserChatRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_chat_rooms do |t|
      t.integer :user_id, null: false
      t.integer :chat_room_id, null: false
      t.timestamps
    end
  end
end
