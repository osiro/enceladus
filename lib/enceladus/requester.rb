require 'rest_client'
require 'ostruct'

class Enceladus::Requester
  class << self
    def get(action, params={})
      url = api.url_for(action, params)
      perform_request do
        JSON.parse(RestClient.get(url, request_headers), object_class: OpenStruct)
      end
    end

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