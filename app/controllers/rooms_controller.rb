class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @chatting_user = @entries.where.not(user_id: current_user.id)

    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.new
    @room.save
    Entry.create(user_id: current_user.id, room_id: @room.id)
    Entry.create(user_id: rooms_params[:user_id], room_id: @room.id)
    redirect_to room_path(@room.id)
  end
  private
  def rooms_params
    params.require(:room).permit(:user_id)
  end
end
