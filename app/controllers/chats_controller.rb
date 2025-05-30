class ChatsController < ApplicationController
    before_action :set_chat, only: :show
    before_action :load_users, only: %i[new create]
    before_action :authenticate_user!
    load_and_authorize_resource
  
    def index
      @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
    end

  
    def show; end
  
    def new
      @chat = Chat.new
      @users = User.where.not(id: current_user.id) # para no mostrarte a ti mismo
    end
  
    def create
      @chat = Chat.new(chat_params)
      @chat.sender_id = current_user.id

      if @chat.save
        redirect_to @chat, notice: "Chat creado correctamente"
      else
        @users = User.where.not(id: current_user.id)
        render :new
      end
    end

    def edit
      @chat = Chat.find(params[:id])
    end

    def update
      @chat = Chat.find(params[:id])
      if @chat.update(chat_params)
        redirect_to @chat, notice: "Chat actualizado correctamente."
      else
        render :edit
      end
    end
  
    private
  
    def set_chat
      @chat = Chat.find(params[:id])
    end
  
    def load_users
      @users = User.all
    end
  
    def chat_params
      params.require(:chat).permit(:receiver_id)
    end

  end
  