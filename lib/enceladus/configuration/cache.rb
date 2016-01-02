require 'singleton'

module Enceladus::Configuration
  # This is a singleton class responsible maintain an instance of a cache client, such as dalli.
  # Check out how to obtain a dalli cache client in here: https://github.com/petergoldstein/dalli#installation-and-usage
  # Other cache clients can also be used as soon as it implements the default Rails ActiveSupport cache store class: http://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html
  class Cache
    include Singleton

    attr_accessor :client
  end
end
