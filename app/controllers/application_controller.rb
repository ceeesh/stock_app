class ApplicationController < ActionController::Base
    helper_method :current_user

    protect_from_forgery with: :null_session

    before_action :authenticate_user
    
    def current_user
        if session[:user_id]
            user = User.find_by(id: session[:user_id])
        end

        # token = session[:user_id]

        # if token.present?
        #     user ||= User.find_by(token: token.to_s.gsub("Token", ""))
        # end
        # token = request.headers['Authorization']
        # # access the token from headers
    
        # if token.present?
        #     user ||= User.find_by(token: token.gsub("Token ", ""))
        #     # finds the user with the given token
        # end
    end
    
    def authenticate_user
        if current_user.nil?
            redirect_to signin_path
            # render json: { unauthenticated: true }, status: 403
            # if the current_user is nil, we render unauthenticated
        end
    end
end
