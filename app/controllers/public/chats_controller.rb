class Public::ChatsController < ApplicationController
  # フォロー関係がない場合に、投稿一覧ページにリダイレクト
  # before_action :reject_non_related, only: [:show]

  def show
    # #チャットする相手を特定
    # @customer = Customer.find(params[:id])
    # #ログイン中のユーザーの部屋情報を全て取得
    # rooms = current_customer.customer_chat_rooms.pluck(:chat_room_id)
    # #その中にチャットする相手とのルームがあるか確認
    # customer_chat_rooms = CustomerChatRoom.find_by(customer_id: @customer.id, chat_room_id: rooms)

    # #ユーザールームがある場合
    # unless customer_chat_rooms.nil?
    #   #変数@roomにユーザー（自分と相手）と紐づいているroomを代入
    #   @room = customer_chat_rooms
    # else
    #   #ユーザールームが無かった場合、新しくRoomを作成
    #   @room = ChatRoom.new
    #   @room.save
    #   #自分の中間テーブルを作成
    #   CustomerChatRoom.create(customer_id: current_customer.id, chat_room_id: @room.id)
    #   #相手の中間テーブルを作成
    #   CustomerChatRoom.create(customer_id: @customer.id, chat_room_id: @room.id)
    # end
    # #チャットの一覧
    # # @chats = @room.chats
    # @chats = @room.chat_room.chats
    # #チャットの投稿
    # @chat = Chat.new(chat_room_id: @room.chat_room.id)

    @target_customer = Customer.find(params[:id])
    my_rooms = current_customer.customer_chat_rooms.pluck(:chat_room_id)
    target_room = CustomerChatRoom.find_by(customer_id: @target_customer, chat_room_id: my_rooms)

    unless target_room.nil?
      @room = target_room.chat_room
    else
      @room = ChatRoom.create()
      CustomerChatRoom.create(customer_id: current_customer.id, chat_room_id: @room.id)
      CustomerChatRoom.create(customer_id: @target_customer.id, chat_room_id: @room.id)
    end


    @chats = @room.chats
    @chat = Chat.new(chat_room_id: @room.id)

  end

  def create
    @chat = current_customer.chats.new(chat_params)
    @room = ChatRoom.find_by(id: params[:chat][:chat_room_id])
    @chats = @room.chats if @room
    pp chat_params
    render :validate, formats: :js unless @chat.save
  end



  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

  # フォロー関係がない場合に、投稿一覧ページにリダイレクト
  # def reject_non_related
  #   customer = Customer.find(params[:id])
  #   unless current_customer.following?(customer) && customer.following?(current_customer)
  #     redirect_to posts_path
  #   end
  # end
end
