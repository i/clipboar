require 'sinatra'
require 'sinatra/reloader'
require 'haml'

get '/' do
  haml :index
end

post '/' do
  doc = params['content']
  name = params['name'].empty?? doc.hash.to_s : params['name']

  while File.exists? "clips/#{name}"  do
    name = name.hash.to_s
  end

  return haml :index if name.match '/'

  begin
    File.open("clips/#{name}", 'w') { |f| f.write(doc) }
    @url = "http://clipboar.org/#{name}"
    haml :pasted
  rescue
    haml :index
  end
end

get '/:id' do
  path = "clips/#{params['id']}"
  if File.exists?(path)
    @buf = File.open(path) { |f| f.read }
    File.delete(path) if not request.env['HTTP_USER_AGENT'].match 'facebook'
    haml :paste
  else
    haml :nopaste
  end
end
