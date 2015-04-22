require 'chronic'

get '/' do
  erb :index
end

post '/texts' do
  # join the date and time to one field
  # create instance of text using incoming data

# date_time =
# Chronic.parse("2015-04-21 09:05:00 PM").to_i
# Time.at(1429675500).to_datetime

data_time = params[:date] + " " + params[:time]

p Chronic.parse('tomorrow')
# is there a better way to save as integer into db so we may unix time


  @text = Text.create(
              recipient: params[:recipient],
              number: params[:number],
              message: params[:message]
              # date_time: date_time
           )
p params
  redirect "/texts/#{@text.id}"
end

get '/texts/:id' do
  @text = Text.where(id: params[:id]).first
  erb :text
end



