require 'spec_helper'
require 'singleton'

describe Enceladus::Logger, logger_test: true do
  let(:logger) { Enceladus::Logger.instance }

  before do
    Singleton.__init__(Enceladus::Logger)
  end

  describe "#new" do
    it "should set log level to ERROR" do
      expect(logger.level).to eq(Enceladus::Logger::ERROR)
    end
  end

  describe ".logger_output=" do
    subject { Enceladus::Logger.logger_output = output }
    let(:output) { "enceladus.log" }

    it "sets the logger output to the one provided" do
      expect{ subject }.to change{ Enceladus::Logger.logger_output }.to(output)
    end
  end

  describe "#enable_debug_mode!" do
    subject { logger.enable_debug_mode! }
    before { logger.level = Enceladus::Logger::FATAL }

    it "should set the logger level to DEBUG" do
      expect{ subject }.to change{ logger.level }.to(Enceladus::Logger::DEBUG)
    end
  end

  describe "#disable_debug_mode!" do
    subject { logger.disable_debug_mode! }
    before { logger.level = Enceladus::Logger::FATAL }

    it "should set the logger level to ERROR" do
      expect{ subject }.to change{ logger.level }.to(Enceladus::Logger::ERROR)
    end
  end
end