class Admin::DashboardController < Admin::BaseController
    layout 'admin/base'
    # before_action :get_user
    
    def index
        # @users = User.all
        # admin/dashboard
        @cur_user = current_user

        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)
    end

    def show
        @user = User.find(params[:id])
        @cur_user = current_user
    end

    def pending_users
        @users = User.all
        @cur_user = current_user
    end

    #get /new
    def new 
        @user = User.new
        @cur_user = current_user
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
        @cur_user = current_user
    end

    def update 
        @user = User.find(params[:id])

        if @user.update(user_params)
            redirect_to admin_dashboard_path(@user.id)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy

        if @user.email_verification?
            redirect_to admin_dashboard_index_path
        else
            redirect_to pending_users_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :balance)
    end

    def signup_params
        params.permit(:email, :password, :password_confirmation)
    end

    # def get_user
    #     @user = User.find_by(session[:token])

    #     if @user.admin?
    #         redirect_to admin_dashboard_index_path
    #     end
    # end

end