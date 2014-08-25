require 'rest_client'
require 'ostruct'

class Enceladus::Requester
  class << self
    # Makes a get request to one of the TMDb API endpoints.
    # Example:
    #
    #   Enceladus::Requester.get("account", { session_id: "43462867" })
    #
    # Performing this action might results in RestClient::Exception.
    # Check out https://github.com/rest-client/rest-client#exceptions-see-wwww3orgprotocolsrfc2616rfc2616-sec10html for more details.
    #
    def get(action, params={})
      url = api.url_for(action, params)
      perform_request do
        JSON.parse(RestClient.get(url, request_headers), object_class: OpenStruct)
      end
    end

    # Makes a post request to TMDb API endpoints.
    # Example:
    #
    #   params = { session_id: "77678687" }
    #   form_data = { media_type: "movie", media_id: 31231, watchlist: true }
    #   Enceladus::Requester.post("account/777/watchlist", params, form_data)
    #
    # Performing this action might results in RestClient::Exception.
    # Check out https://github.com/rest-client/rest-client#exceptions-see-wwww3orgprotocolsrfc2616rfc2616-sec10html for more details.
    #
    def post(action, params={}, form_data={})
      url = api.url_for(action, params)
      perform_request do
        JSON.parse(RestClient.post(url, form_data.to_json, request_headers), object_class: OpenStruct)
      end
    end

  private
    def api
      Enceladus::Configuration::Api.instance
    end

    # Handles request calls exceptions.
    # Performing RestClient actions might results in RestClient::Exception.
    # Check out https://github.com/rest-client/rest-client#exceptions-see-wwww3orgprotocolsrfc2616rfc2616-sec10html for more details.
    #
    # So, this method is responsible for handling RestClient::Exception, parsing the error message to finally raise Enceladus::Exception::Api.
    #
    def perform_request(&block)
      begin
        block.call
      rescue RestClient::Exception => e
        message = ["The Movie DB API Exception:"]
        message << "@message=\"#{e.message}\""

        JSON.parse(e.response).each do |k,v|
          message << "@#{k}=\"#{v}\""
        end

        raise Enceladus::Exception::Api.new(message.join(" "))
      end
    end

    def request_headers
      { accept: 'application/json', content_type: 'application/json' }
    end
  end
end