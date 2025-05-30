class MessagesController < ApplicationController
  before_action :set_message, only: :show
  before_action :load_associations, only: %i[new create]
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @messages = Message.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
    @chats = current_user.chats
    @users = User.where.not(id: current_user.id)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    if @message.save
      redirect_to messages_path, notice: "Mensaje enviado correctamente"
    else
      render :new
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to @message, notice: "Mensaje actualizado correctamente."
    else
      render :edit
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def load_associations
    @chats = current_user.chats
    @users = User.where.not(id: current_user.id)
  end


  def message_params
    params.require(:message).permit(:chat_id, :recipient_id, :body)
  end

end
