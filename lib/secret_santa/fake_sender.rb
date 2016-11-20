class FakeSender
  attr_accessor :client, :from

  def initialize(client, from)
    self.client = client
    self.from = from
  end

  def send(to, body)
    client.log "TESTING: not really sending text messages"
    client.log "The message would be as follows:"
    client.log "to: #{to}"
    client.log "message: #{body}"
    client.log "========================================="
  end
end
