class IexClient
        TOKEN = Rails.application.credentials.dig(:publishable_token)
        BASE_URL = "https://api.iex.cloud/v1/data/CORE/REF_DATA"

        def self.call
            result = RestClient.get("#{BASE_URL}?token=#{TOKEN}", 
                headers= {'Content-type' => 'application/json' })
                JSON.parse(result.body)
                
        end
end



# class IexCloud
#     TOKEN = Rails.application.credentials.dig(:publishable_token)
#     BASE_URL = "https://api.iex.cloud/v1/data/CORE/REF_DATA"

#     def self.call
#         result = RestClient::Request.execute(
#             method: 'get',
#             url: "#{BASE_URL}?token=#{TOKEN}",
#             headers: {'Content-Type' => 'application/json'}
#         )
#         JSON.parse(result.body, object_class: OpenStruct)
#     end
# end