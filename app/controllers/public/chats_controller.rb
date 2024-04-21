class Public::ChatsController < ApplicationController
  # フォロー関係がない場合に、投稿一覧ページにリダイレクト
  # before_action :reject_non_related, only: [:show]
  
  def show
     #チャットする相手を特定
    @customer = Customer.find(params[:id])
    #ログイン中のユーザーの部屋情報を全て取得
    rooms = current_customer.customer_chat_rooms.pluck(:room_id) 
    #その中にチャットする相手とのルームがあるか確認
    customer_chat_rooms = CustomerChatRoom.find_by(customer_id: @customer.id, room_id: rooms)

    #ユーザールームがある場合
    unless customer_chat_rooms.nil?
      #変数@roomにユーザー（自分と相手）と紐づいているroomを代入
      @room = customer_chat_rooms.room
    else
      #ユーザールームが無かった場合、新しくRoomを作成
      @room = ChatRoom.new
      @room.save
      #自分の中間テーブルを作成
      CustomerChatRoom.create(customer_id: current_customer.id, chat_room_id: @room.id)
      #相手の中間テーブルを作成
      CustomerChatRoom.create(customer_id: @customer.id, chat_room_id: @room.id)
    end
    #チャットの一覧
    @chats = @room.chats
    #チャットの投稿
    @chat = Chat.new(chat_room_id: @room.id)
  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @room = @chat.room
    @chats = @room.chats
    render :validater unless @chat.save
  end

  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
  
  # フォロー関係がない場合に、投稿一覧ページにリダイレクト
  # def reject_non_related
  #   customer = Customer.find(params[:id])
  #   unless current_customer.following?(customer) && customer.following?(current_customer)
  #     redirect_to posts_path
  #   end
  # end
end
