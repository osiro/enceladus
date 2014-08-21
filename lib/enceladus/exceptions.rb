module Enceladus::Exception
  class Base < ::Exception; end
  class Api < Base; end
  class ArgumentError < Base; end
end