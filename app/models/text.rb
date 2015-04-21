require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

class Text < ActiveRecord::Base
  def intialize

  account_sid = 'AC689eabd9c24755564bcfe18cab80ee8a'
  auth_token = 'e2e65eb3f7f08688133d20014994d71c'

  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new account_sid, auth_token

  @client.account.messages.create({
    :from => '+14023251257',
  })

  end
end