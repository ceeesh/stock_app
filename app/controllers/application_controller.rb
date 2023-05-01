class ApplicationController < ActionController::Base
    # helper_method :current_user

    protect_from_forgery with: :null_session

    before_action :authenticate_user

    
    
    def current_user
        if session[:token]
            user = User.find_by(token: session[:token])
        end

    end
    
    def authenticate_user
        if current_user.nil?
            redirect_to signin_path
        end
    end

    def check_role
        if current_user.admin?
            redirect_to admin_dashboard_index_path
        end
    end
end
