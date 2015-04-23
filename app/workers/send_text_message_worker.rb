class SendTextMessageWorker
  @queue = :default

  def self.perform(text_id)
    begin
      puts "sending test message id: #{text_id}"
      text = Text.find(text_id)
      text.send_message!
    rescue Exception => error
      puts "FAILED TO SEND TEXT!"
      puts error.message
      puts *error.backtrace
    end
  end
end
