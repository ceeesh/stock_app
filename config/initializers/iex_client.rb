require "iex-ruby-client"

    IEX_CLIENT = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.dig(:publishable_token),
        endpoint: 'https://cloud.iexapis.com/v1'
      )

