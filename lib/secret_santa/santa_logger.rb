class SantaLogger
  attr_accessor :sending

  def initialize(sending = false)
    self.sending = sending
  end

  def log(message)
    puts "#{message}" unless sending  # Sshh! It's a secret!
  end

end
