
helpers do


def send_message(text)
  p account_sid = ENV['ACCOUNT_SID']
  p ENV['ACCOUNT_SID']
  p auth_token = ENV['AUTH_TOKEN']
  p ENV['AUTH_TOKEN']

# set up a client to talk to the Twilio REST API
 @client = Twilio::REST::Client.new account_sid, auth_token
 @client.account.messages.create({
    from: '+14023251257',
    to: text.number,
    body: text.message })
 end


end
