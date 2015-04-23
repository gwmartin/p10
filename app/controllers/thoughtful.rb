get '/' do
  erb :index
end

get '/worker_test' do
  Resque.enqueue(HardWorker, params)
  "There are #{Resque.size(:default)} jobs in the default queue"
end

post '/texts' do

  date_time = params[:date] + " " + params[:time]
  time_stamp = Chronic.parse(date_time)


  @text = Text.create(
              recipient: params[:recipient],
              number: params[:number],
              message: params[:message],
              date_time: time_stamp
           )

  puts "BEFORE HARDWORKER"
  HardWorker.perform_async('bob', 5)
  puts "AFTER HARDWORKER"
  # send_message(@text)
  redirect "/"
end

get '/texts/:id' do
  @text = Text.where(id: params[:id]).first
  erb :text
end




