class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    p 'Doing hard work'
    p 'Doing hard work'
    p 'Doing hard work'
  end
end
