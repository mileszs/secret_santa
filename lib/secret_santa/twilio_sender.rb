class TwilioSender
  attr_accessor :client, :from

  def initialize(twilio_client, from)
    self.client = twilio_client
    self.from = from
  end

  def send(to, body)
    client.account.messages.create({
      from: from,
      to: to,
      body: body,
    })
  end
end
