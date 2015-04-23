require 'chronic'
require 'resque'

get '/' do
  erb :index
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
  send_message(@text)
  redirect "/"
end

get '/texts/:id' do
  @text = Text.where(id: params[:id]).first
  erb :text
end




