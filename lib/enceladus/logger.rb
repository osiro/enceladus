require 'logger'
require 'singleton'

# Logger is a class implemented by using the singleton pattern mainly responsible for loggin requests, responses and exceptions.
# Examples:
#   Enceladus::Logger.log.error { "Woops! Something when wrong..." }
#   Enceladus::Logger.log.info { "Yay! That works like a charm!" }
#   Enceladus::Logger.log.warn { "Hummm... code smells here..." }
#   Enceladus::Logger.log.fatal { "Game over..." }
#
class Enceladus::Logger < Logger
  include Singleton

  # By default Enceladus::Logger logs messages to STDOUT and the default log level is Logger::ERROR (check out http://www.ruby-doc.org/stdlib-2.0.0/libdoc/logger/rdoc/Logger.html#class-Logger-label-Description for more information).
  @@logger_output = STDOUT

  class << self
    def new
      super(logger_output).tap do |logger|
        logger.disable_debug_mode!
      end
    end

    alias :log :instance

    # Defines where to log messages.
    # Example:
    #   Enceladus::Logger.logger_output = Rails.root.join("log", "enceladus.log")
    #
    def logger_output=(output)
      @@logger_output = output
    end

    # Returns the current logger output.
    # Example:
    #   Enceladus::Logger.logger_output
    #   => "/Users/john/super_project/log/enceladus.log"
    #
    def logger_output
      @@logger_output
    end
  end

  # Changes the log level to DEBUG.
  # Example:
  #   Enceladus::Loger.instance.enable_debug_mode!
  def enable_debug_mode!
    self.level = Enceladus::Logger::DEBUG
  end

  # Disables the debug mode by changing the log level to ERROR.
  # Example:
  #   Enceladus::Loger.instance.disable_debug_mode!
  def disable_debug_mode!
    self.level = Enceladus::Logger::ERROR
  end
end