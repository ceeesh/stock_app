class HomeController < ApplicationController
    def index
        @client = IEX::Api::Client.new(
            publishable_token: 'pk_34fbdfadc81c40ac87e98e4cf14d5edb',
            endpoint: 'https://cloud.iexapis.com/v1'
          )
        @quote = @client.quote('MSFT')

        if current_user
          @user = current_user.email
        end

        @chart = @client.chart('MSFT', '1d', chart_interval: 10)
     end
end