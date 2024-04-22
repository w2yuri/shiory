class Public::ChatGroupsController < ApplicationController
  def index
    # データベースから対象のカスタマーを検索
    @target_customer = current_customer
    # ログインしているカスタマーのチャットルームのIDを取得
    target_chat_room_ids = current_customer.customer_chat_rooms.pluck(:chat_room_id)
    # 対象のカスタマーとログインしているカスタマーのチャットルームを検索
    #target_room = CustomerChatRoom.find_by(customer_id: @target_customer, chat_room_id: my_rooms)
    @my_customer_chat_rooms = CustomerChatRoom.where(chat_room_id: target_chat_room_ids).where.not(customer_id: current_customer)
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

  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

end
