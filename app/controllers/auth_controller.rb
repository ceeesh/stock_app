class AuthController < ApplicationController
    skip_before_action :authenticate_user
    

    # GET /signin
    def signin
    end

    # GET /signup
    def signup
    end 

    def new_session
        if user = User.signin(user_params)
            session[:token] = user.token
            if user.admin?
                redirect_to admin_dashboard_index_path
            else
                redirect_to root_path notice: "Logged in successfully"
                puts "We're in"
            end
        else
            flash.now[:alert] = "Invalid email or password"
            render :signin, json: { not_found: true }, status: 403
        end
    end



    # POST /signup
    def new_account
        if (signup_params[:password] == signup_params[:password_confirmation])
            @user = User.signup(user_params)

            UserMailer.with(user: user_params).welcome_email.deliver_later

            puts 'hello we"ve done it'
            redirect_to signin_path
            print user
            puts 'no new'
        else
            # flash.now[:notice] = user.errors.full_messages.to_sentence
            render :signup, status: :unprocessable_entity
        end 
    end

    def logout
        session[:token] = nil
        redirect_to signin_path, notice: "Logged out"
    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def signup_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end