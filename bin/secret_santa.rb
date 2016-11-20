#!/usr/bin/env ruby

require "ostruct"
require_relative "../lib/secret_santa"

# Do some testing, then set this to true when ready to send
# Will cause logging output to be shushed and mails to be sent
REALLY_SENDING = ENV.fetch("REALLY_SENDING", false)

Logger = SantaLogger.new(REALLY_SENDING)

people_config = YAML.load_file('config/people.yml')
twilio_config = OpenStruct.new(YAML.load_file('config/twilio.yml'))
twilio_client = Twilio::REST::Client.new(twilio_config.twilio_account_sid, twilio_config.twilio_auth_token)

people = people_config['people'].map do |attrs|
  Person.new(attrs)
end

santas = people.dup
people.each do |person|
  person.santa = santas.delete_at(rand(santas.size))
end

Logger.log "Initial Santa assignments:"
people.each do |person|
  Logger.log person.with_santa
end

# This is the nice part of Dennis's solution: if there are any invalid
# assignments, they are corrected in as few passes as possible. (I
# originally said "a single pass", but that's not true because the
# `select` that looks for someone to swap santas with is just a
# way of saying "loop through the list of people looking for a match.")
# This works because corrections are made in a way that ensures no new 
# invalid assignments are created.
Logger.log "Checking assignments for validity"
people.each do |person|
   unless person.santa.can_be_santa_of?(person)
     Logger.log "\n#{person} can't get a gift from #{person.santa}! Let's try to fix that..."
     swap_candidates = people.select {|p| person.can_swap_santas_with?(p) }
     raise "Failure! No one can swap santas with #{person}" if swap_candidates.empty?
     Logger.log "Any of these can swap santas with #{person}: #{swap_candidates.map(&:to_s)}"
     swapper = swap_candidates.sample
     Logger.log "Chose #{swapper} to swap santas with #{person}"
     misplaced_santa = person.santa
     person.santa    = swapper.santa
     swapper.santa   = misplaced_santa
   end
end

Logger.log "\n\nFinal Santa assignments:"
people.each do |person|
  Logger.log person.with_santa
end

sender = if REALLY_SENDING
  TwilioSender.new(
    twilio_client,
    twilio_config.twilio_from_number
  )
else
  FakeSender.new(
    Logger,
    twilio_config.twilio_from_number
  )
end

people.each do |person|
  message = "THIS IS SANTABOT 5000. YOU ARE ORDERED TO BUY A PRESENT FOR THE MEAT-BAG NAMED #{person.name.upcase}."
  sender.send(person.santa.phone, message)
end
