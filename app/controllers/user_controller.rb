class UserController < ApplicationController
    # before_action :authenticate_user

    def index
        if current_user
        @user = current_user.email
        end
    end



    private
end