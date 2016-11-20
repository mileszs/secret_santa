require "minitest/autorun"
require_relative "../lib/secret_santa/twilio_sender"
require "ostruct"

class TwilioSenderTest < Minitest::Test
  def test_send_attempts_to_create_a_message
    messages_mock = MiniTest::Mock.new
    client = OpenStruct.new(
      account: OpenStruct.new(
        messages: messages_mock
      )
    )
    messages_mock.expect(
      :create,
      nil,
      [{ from: "15555555555", to: "15555555555", body: "A message body"}]
    )

    sender = TwilioSender.new(client, "15555555555")
    sender.send("15555555555", "A message body")
    messages_mock.verify
  end
end
