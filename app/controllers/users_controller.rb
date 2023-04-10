class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # 相互フォローの判定
    @is_mutual_follow = reject_mutual_follow(@user)
    # チャットルームを作成済みか判定
    already_create_chat_room(@user)
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def already_create_chat_room(user)
    rooms = current_user.entries.pluck(:room_id)
    # 参照しているユーザーが作成しているエントリーを取得
    # roomsを引数に渡すことで、ログイン中のユーザーが作成しているチャットルームのidが存在しているかを判定
    # ※ ユーザー同士のチャットルームは1つしか作成できないため、entrieは必ず一つに定まる。
    entrie = Entry.find_by(user_id: user.id, room_id: rooms)
    unless entrie.blank?
      @is_room = true 
      @room = entrie.room
    else
      @room = Room.new
    end
  end
  def reject_mutual_follow(user)
    if current_user.following?(user) && user.following?(current_user)
      return true
    else
      return false
    end
  end
end
