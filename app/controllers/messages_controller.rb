class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(user_id: current_user.id,message: message_params[:message],room_id: message_params[:room_id])
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
    redirect_back(fallback_location: root_path)
  end
  private
  def message_params
    params.require(:message).permit(:user_id, :message, :room_id)
  end
end
