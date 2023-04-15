class Admin::DashboardController < Admin::BaseController
    layout 'admin/base'
    
    def index
        @users = User.all
    end
end