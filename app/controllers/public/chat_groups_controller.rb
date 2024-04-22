class Public::ChatGroupsController < ApplicationController
  
  def index
    # ログインしているカスタマーを代入
    @target_customer = current_customer
    # ログインしているカスタマーが参加している複数のチャットルームのidを取得し特定
    target_chat_room_ids = current_customer.customer_chat_rooms.pluck(:chat_room_id)
    # ログインしているカスタマーのチャットルームが重複してしまうため、ログインカスタマー以外のチャットルームを取得し代入
    @my_customer_chat_rooms = CustomerChatRoom.where(chat_room_id: target_chat_room_ids).where.not(customer_id: current_customer)
  end 

  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

end
