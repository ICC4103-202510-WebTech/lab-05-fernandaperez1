class UsersController < ApplicationController
    before_action :set_user, only: :show
    before_action :authenticate_user!
    load_and_authorize_resource
  
    def index
      if current_user.admin?
        @users = User.all
      else
        redirect_to chats_path, alert: "No tienes permiso para ver esta página."
      end
    end
  
    def show; end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to @user, notice: 'Usuario registrado correctamente.'
      else
        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user, notice: "Usuario actualizado correctamente."
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      if @user == current_user
        redirect_to users_path, alert: "No puedes eliminarte a ti mismo."
      else
        @user.destroy
        redirect_to users_path, notice: "Usuario eliminado correctamente."
      end
    end


    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
  end
  