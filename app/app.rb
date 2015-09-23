require 'sinatra/base'
require_relative '../data_mapper_setup'

class BookmarksWeb < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post '/links' do
  link=Link.create(url: params[:url], title: params[:title] )
  tag=Tag.create(name: params[:tag])
  link.tags << tag
  link.save
    redirect '/links'
  end

  get '/links/new' do
    erb :links_new
  end

  set :views, proc { File.join(root, 'views') }
  # start the server if ruby file executed directly
  run! if app_file == $0

end
