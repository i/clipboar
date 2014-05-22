require 'sinatra'
require 'haml'

get '/' do
  haml :index
end

get '/p/:id' do
  @id = params['id']
  haml :paste
end
