require 'sinatra'
require 'sinatra/reloader'
require 'haml'

get '/' do
  haml :index
end

post '/' do
  doc = params['content']
  puts doc.class
  File.open("clips/#{doc.hash}", 'w') { |f| f.write(doc) }
  doc.hash.to_s
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
