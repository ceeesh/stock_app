class AuthController < ApplicationController
    skip_before_action :authenticate_user
    

    # GET /signin
    def signin
        
    end

    # GET /signup
    def signup
    end 

    def new_session
        # @user = User.new(email: user_params[:email], password: user_params[:password])
        
        @user = User.find_by(email: user_params[:email])
        if @user && @user.password == user_params[:password_digest]
            session[:user_id] = @user.id
            redirect_to root_path notice: "Logged in successfully"
            puts "We're in"
            # format.json { render token: user.token, status: 200 }
        else
            flash.now[:notice] = "Invalid email or password"
            render :signin, json: { not_found: true }, status: 403
        end
    end



    # POST /signup
    def new_account
    #     # @user = User.new(signup_params)
        
    #     # if @user.save
    #     #     redirect_to root_path
    #     # else
    #     #     render :signin, status: :unprocessable_entity
    #     # end
        if (signup_params[:password] == signup_params[:password_confirmation])
            @user = User.signup(user_params)

            puts 'hello we"ve done it'
            redirect_to signin_path
        else
            flash.now[:notice] = @user.errors.full_messages.to_sentence
            render :signup, status: :unprocessable_entity
        end 
    end

    def logout
        session[:user_id] = nil
        redirect_to signin_path, notice: "Logged out"
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def signup_params
        params.permit(:email, :password, :password_confirmation)
    end
end