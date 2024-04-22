class Admin::ChatGroupsController < ApplicationController
  
  def index
    @messages = Chat.all 
  end
  
  def destroy
    @messages = Messages.find(params[:id])
    @messages.destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :chat_room_id)
  end

end
