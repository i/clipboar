require 'sinatra'
require 'sinatra/reloader'
require 'haml'

get '/' do
  haml :index
end

post '/' do
  doc = params['content']
  name = (params['name'].empty?)? doc.hash : params['name']
  File.open("clips/#{name}", 'w') { |f| f.write(doc) }
  @url = "localhost:4567/#{name}"
  haml :pasted
end

get '/:id' do
  path = "clips/#{params['id']}"
  if File.exists?(path)
    @buf = File.open(path) { |f| f.read }
    File.delete(path)
    haml :paste
  else
    haml :nopaste
  end
end
