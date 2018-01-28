class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def new
        @user = User.new
    end
    
    def edit
    end


    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
                session[:user_id] = @user.id
                format.html {redirect_to user_path(@user)}
            else
                format.html { redirect_to root_path }
            end
        end
    end

    def show
        @message = params[:message] if params[:message]

        if session[:user_id] != @user.id
            redirect_to root_path
        end
    end

    def update
        if @user.update(user_params)
            redirect_to @user
        else
            render :edit
        end
    end

    private
    
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :password, :password_confirmation, :nausea, :happiness, :tickets, :height, :admin)
    end
end
