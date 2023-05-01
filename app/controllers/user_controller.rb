class UserController < ApplicationController
    # before_action :authenticate_user

    def index
        if current_user
        @user = current_user.email
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to @user
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def delete
        @user = User.find(params[:id])
        @user.destroy

        redirect_to admin_dashboard_index_path
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
#Hi!