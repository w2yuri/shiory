class Public::ChatsController < ApplicationController
  before_action :authenticate_customer!

  def show
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

  def create
    @chat = current_customer.chats.new(chat_params)
    # idが一致するチャットルーム取得
    @room = ChatRoom.find_by(id: params[:chat][:chat_room_id])
    # @roomが存在する場合のみ、チャット一覧を取得
    @chats = @room.chats if @room
    # チャットの保存に失敗した場合、jsのエラーメッセージを表示し、チャットの保存にしたら続行
    render :validate, formats: :js unless @chat.save
  end
  
  def destroy
    @chat = Chat.find(params[:id])
    @chat.destroy
    @chats = Chat.where(chat_room_id: @chat.chat_room_id)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

end
