require 'twilio-ruby'
require 'pry-byebug'
require 'csv'

class Logger
  def initialize
    @file_path = 'logs.csv'
  end

  def report(phone_number, exception)
    CSV.open(@file_path, "w") do |csv|
      csv << [phone_number, exception]
    end
  end
end


class TwilioService
  LOGGER = Logger.new
  ACCOUNT_SID = 'AC08b9d5439ca5f6e0fce47f8d1043c58a'
  AUTH_TOKEN = '0be822126371bee0f7114dd342000776'
  MESSAGING_SERVICE_SID = 'MGb10f3fda35f0d0ae66dc1e8b9ee017e3'
  CLIENT = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

  def self.call(phone_number, sms_body)
    message = CLIENT.messages.create(
        messaging_service_sid: MESSAGING_SERVICE_SID,
        body: sms_body,
        to: phone_number
    )
  rescue => e
    puts e
    LOGGER.report(phone_number, e)
  end
end

message = "This is a potato"
numbers = ['+6590370018', '+6555555555']

numbers.each do |num|
  TwilioService.call(num, message)
end
