require 'sinatra/base'
require_relative '../data_mapper_setup'


class BookmarksWeb < Sinatra::Base
enable :sessions
set :session_secret, 'super secret'

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    # if User.first(id: session[:user_id])
    #   @email = User.first(id: session[:user_id]).email
    # end
    erb :links
  end

  post '/links' do
    link=Link.new(url: params[:url], title: params[:title] )
    strings=params[:tags].split(/\s+/)
    strings.each do |string|
      link.tags << Tag.first_or_create(name: string)
    # strings = params[:tag].split(/\s+/)
    # tags = strings.map { |tag| Tag.create(name: tag) }
    end
    link.save
    redirect '/links'
  end

  get '/links/new' do
    erb :links_new
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links'
  end

  get '/users/new' do
    erb  :'users/new'
  end

  post '/users' do
    user = User.create(email: params[:email],
              password: params[:password],
              password_confirmation: params[:password_confirmation])
    session[:user_id] = user.id
    redirect to ('/links')
  end

     helpers do
     def current_user
         current_user ||= User.first(id: session[:user_id])
     end
  end

  set :views, proc { File.join(root, 'views') }
  # start the server if ruby file executed directly
  run! if app_file == $0

end
