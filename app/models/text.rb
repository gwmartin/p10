class Text < ActiveRecord::Base

  def self.twilio_client
    @twilio_client ||= Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
  end

  validates :number,           presence: true
  validates :recipient,        presence: true
  validates :message,          presence: true
  validates :expected_sent_at, presence: true

  scope :needs_to_be_sent, ->{
    where('texts.expected_sent_at <= now() AND texts.sent_at IS NULL')
  }

  def expected_sent_at=(time)
    time = Chronic.parse(time) if time.is_a?(String)
    super time
  end

  def send_message!
    # set up a client to talk to the Twilio REST API
    self.class.twilio_client.account.messages.create({
      from: '+14023251257',
      to: self.number,
      body: self.message,
    })
    self.update_attribute(:sent_at, Time.now)
  end

end
