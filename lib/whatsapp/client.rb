module Whatsapp
  class Client
    API_VERSION = "v13.0"
    API_CLIENT = "https://graph.facebook.com/#{API_VERSION}/"

    def initialize(access_token)
      @access_token = access_token
    end

    def client
      @_client ||= ::Faraday.new(API_CLIENT) do |client|
        client.request :url_encoded
        client.adapter ::Faraday.default_adapter
        client.headers['Authorization'] = "Bearer #{@oauth_token}" unless @oauth_token.nil?
      end
    end

    def send_request(http_method: "post", endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)
      Oj.load(response.body)
    end
  end
end