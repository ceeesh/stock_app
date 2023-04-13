class HomeController < ApplicationController
    def index
        @client = IEX::Api::Client.new(
            publishable_token: 'pk_34fbdfadc81c40ac87e98e4cf14d5edb',
            endpoint: 'https://cloud.iexapis.com/v1'
          )
        @quote = @client.quote('MSFT')
     end
end