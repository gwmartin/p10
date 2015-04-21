get '/' do
  erb :index
end


post '/text/:id' do
  # @text = Text.create(number: params[:number],
  #             message: params[:message]
  #          )
p params
  redirect '/'
end
