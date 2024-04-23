class Admin::ChatGroupsController < ApplicationController

  def index
    @messages = Chat.all
  end

  def destroy
    @messages = Chat.all
    Chat.find(params[:id]).destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:message)
  end

end
