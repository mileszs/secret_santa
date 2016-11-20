require "minitest/autorun"
require_relative "../lib/secret_santa/santa_logger"

class SantaLoggerTest < Minitest::Test
  def test_log_does_not_output_anything_if_really_sending
    logger = SantaLogger.new(true)
    assert_output("") { logger.log("hobbitses") }
  end

  def test_log_outputs_if_not_sending
    logger = SantaLogger.new(false)
    assert_output(/hobbitses/) { logger.log("hobbitses") }
  end
end
