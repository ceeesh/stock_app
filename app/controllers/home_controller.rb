class HomeController < ApplicationController
      # before_action :get_user

    def index
   
        @quote = IEX_CLIENT.quote('MSFT')

        if current_user
          @user = current_user
        end

        @mostactive = IEX_CLIENT.stock_market_list(:mostactive)
        # @chart = @client.chart('MSFT', '1d', chart_interval: 10)
        @logo = IEX_CLIENT.logo('data')

     end

    #  IEX::Api.configure do |config|
    #   config.publishable_token
    #   config.secret_token
    #   config.endpoint
    # end
    
    # @iex_client = IEX::Api::Client.new

    private

    def get_user
      @user = User.find_by(id: session[:user_id])

      if !@user.admin?
          redirect_to root_path
      # else
      #     redirect_to admin_dashboard_index_path
      end
  end
end

