# Resque.enqueue(HardWorker, 'example', 'arguments')
class HardWorker
  @queue = :default

  def self.perform(params)
    puts '~' * 100
    puts "HardWorker is working on #{params.inspect}"
    puts '~' * 100
  end

end
