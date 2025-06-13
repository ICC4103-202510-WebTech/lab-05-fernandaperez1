class MessagesController < ApplicationController
  before_action :set_message, only: :show
  before_action :load_associations, only: %i[new create]
  before_action :authenticate_user!
  load_and_authorize_resource


  def index
    if current_user.admin?
      @messages = Message.all.includes(:sender, :recipient, :chat)
    else
      @messages = Message.where("sender_id = ? OR recipient_id = ?", current_user.id, current_user.id)
    end
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

  def destroy
    @message = Message.find(params[:id])
    authorize! :destroy, @message
    @message.destroy
    redirect_to messages_path, notice: "Chat eliminado"
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
