class ScheduleMessagesThatNeedToBeSentWorker
  @queue = :default

  def self.perform
    puts "~" * 100
    puts "WHAT TEXTS SHOULD I SEND??"
    p Text.needs_to_be_sent.to_a
    Text.needs_to_be_sent.find_each do |text|
      Resque.enqueue(SendTextMessageWorker, text.id)
    end
  end

end
