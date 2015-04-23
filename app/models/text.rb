require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

class Text < ActiveRecord::Base

  def self.twilio_client
    @twilio_client ||= Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
  end

  def send_message!
    # set up a client to talk to the Twilio REST API
    self.class.twilio_client.account.messages.create({
      from: '+14023251257',
      to: self.number,
      body: self.message,
    })
  end

end
