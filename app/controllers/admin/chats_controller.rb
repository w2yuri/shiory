class Admin::ChatsController < ApplicationController
  before_action :find_target_customer, only: [:show]

  def show
    my_rooms = current_customer.customer_chat_rooms.pluck(:chat_room_id)
    target_room = CustomerChatRoom.find_by(customer_id: @target_customer.id, chat_room_id: my_rooms)

    if target_room
      @room = target_room.chat_room
    else
      @room = ChatRoom.create
      CustomerChatRoom.create(customer_id: current_customer.id, chat_room_id: @room.id)
      CustomerChatRoom.create(customer_id: @target_customer.id, chat_room_id: @room.id)
    end

    @chats = @room.chats
    @chat = Chat.new(chat_room_id: @room.id)
  end

  private

  def find_target_customer
    @target_customer = Customer.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end
end
