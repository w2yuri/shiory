class Admin::ChatsController < ApplicationController

    # データベースから対象のカスタマーを検索
    @target_customer = Customer.find(params[:id])
    # ログインしているカスタマーのチャットルームのIDを取得
    my_rooms = current_customer.customer_chat_rooms.pluck(:chat_room_id)
    # 対象のカスタマーとログインしているカスタマーのチャットルームを検索
    target_room = CustomerChatRoom.find_by(customer_id: @target_customer, chat_room_id: my_rooms)

    # チャットルームが存在しているか確認
    unless target_room.nil?
      @room = target_room.chat_room
    else
      @room = ChatRoom.create
      # ログインしているカスタマーとチャットルームの中間テーブル作成
      CustomerChatRoom.create(customer_id: current_customer.id, chat_room_id: @room.id)
      # 対象のカスタマーとチャットルームの中間テーブル作成
      CustomerChatRoom.create(customer_id: @target_customer.id, chat_room_id: @room.id)
    end
      @chats = @room.chats
      @chat = Chat.new(chat_room_id: @room.id)
  　end


  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

end
