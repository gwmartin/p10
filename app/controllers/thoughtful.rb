get '/' do
  @text = Text.new
  erb :index
end

get '/worker_test' do
  Resque.enqueue(HardWorker, params)
  "There are #{Resque.size(:default)} jobs in the default queue"
end

post '/texts' do

  @text = Text.new(
    recipient: params[:recipient],
    number: params[:number],
    message: params[:message],
    expected_sent_at: params[:expected_sent_at],
  )
  if @text.save
    redirect "/"
  else
    raise @text.errors.full_messages.inspect
    erb :index
  end
end

get '/texts/:id' do
  @text = Text.where(id: params[:id]).first
  erb :text
end




