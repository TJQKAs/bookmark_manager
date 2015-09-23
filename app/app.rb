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

  set :views, proc { File.join(root, 'views') }
  # start the server if ruby file executed directly
  run! if app_file == $0

end
