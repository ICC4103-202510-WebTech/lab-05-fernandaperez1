class MessagesController < ApplicationController
  before_action :set_message, only: :show
  before_action :load_associations, only: %i[new create]

  def index
    @messages = Message.all
  end

  def show; end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to @message, notice: 'El mensaje fue enviado correctamente.'
    else
      render :new
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def load_associations
    @chats = Chat.all
    @users = User.all
  end

  def message_params
    params.require(:message).permit(:body, :user_id, :chat_id)
  end
end
