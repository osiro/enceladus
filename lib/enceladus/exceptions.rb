module Enceladus::Exception
  class Base < ::Exception
    def initialize(message)
      Enceladus::Logger.log.error { message }
      super(message)
    end
  end

  class Api < Base; end
  class ArgumentError < Base; end
  class JsonParseError < Base; end
end