require 'twilio-ruby'

account_sid = 'AC08b9d5439ca5f6e0fce47f8d1043c58a'
auth_token = '[AuthToken]'
@client = Twilio::REST::Client.new(account_sid, auth_token)

message = @client.messages.create(
                             messaging_service_sid: 'MGb10f3fda35f0d0ae66dc1e8b9ee017e3',
                             to: '+6590370018'
                           )

puts message.sid
