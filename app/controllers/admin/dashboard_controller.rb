class Admin::DashboardController < Admin::BaseController
    layout 'admin/base'
    
    def index
        @users = User.all
        # admin/dashboard
    end

    def show
        @user = User.find(params[:id])
    end

    #get /new
    def new 
        @user = User.new
    end

    # POST /new
    def create
       @user = User.new(user_params)

       if @user.save
        redirect_to admin_dashboard_index_path
       else
        render :new, status: :unprocessable_entity
       end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update 
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to admin_dashboard_path(@user.id)
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
        params.require(:user).permit(:email, :password, :password_confirmation, :balance)
    end

    def signup_params
        params.permit(:email, :password, :password_confirmation)
    end

    # def get_user
    #     @user = User.find_by_admin(session[:user_id])

    #     if @user.admin?
    #         redirect_to admin_dashboard_index_path
    #     end
    # end

end