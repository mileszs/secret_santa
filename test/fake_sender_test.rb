require "minitest/autorun"
require_relative "../lib/secret_santa/fake_sender"
require_relative "../lib/secret_santa/santa_logger"
require "ostruct"

class FakeSenderTest < Minitest::Test
  def test_send_outputs_a_testing_log_message
    logger = SantaLogger.new
    sender = FakeSender.new(logger, "15555555555")
    assert_output(/TESTING/) do
      sender.send("15555555555", "A message body")
    end
  end
end
