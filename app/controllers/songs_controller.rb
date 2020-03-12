require 'rack-flash'
class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end
  
    get '/songs/new' do
        erb :'songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    post '/songs' do
        artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song = Song.find_or_create_by(name: params[:song][:name], artist: artist)
        params[:genres].each do |genre_id|
            genre = Genre.find_or_create_by(id: genre_id.to_i)
            @song.genres << genre

        end
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    patch '/songs/:slug/edit' do
        artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song = Song.find_by_slug(params[:slug])
        @song.update(name: params[:song][:name], artist: artist)
        params[:genres].each do |genre_id|
            genre = Genre.find_or_create_by(id: genre_id.to_i)
            #if
            @song.genres << genre

        end
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end

end