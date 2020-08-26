# frozen_string_literal: true

require 'sinatra/base'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base
 enable :sessions, :method_override

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @BM = Bookmark.all
    erb :bookmarks
  end

  get '/bookmarks/new' do
    erb :'/bookmarks/new'
  end 

  post '/bookmarks' do
  Bookmark.create(url: params[:url], title: params[:title])
  redirect '/bookmarks'
  end 

  delete '/bookmarks/:id' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("DELETE FROM bookmarks WHERE id = #{params['id']}")
    redirect '/bookmarks'
  end

  run! if app_file == $0  
end
