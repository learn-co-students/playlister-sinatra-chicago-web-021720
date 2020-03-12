require 'rack-flash'

class SongsController < ApplicationController

    enable :sessions
    use Rack::Flash

    get '/songs' do
        @songs = Song.order(:name)
        erb :'songs/index'
    end

    get '/songs/new' do
        erb :'songs/new'
    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    post '/songs' do
        song_name = params[:song][:name]
        artist_name = params[:song][:artist_name]
        genre_names = params[:song][:genre_names]

        artist = Artist.find_or_create_by(name: artist_name)
        genres = genre_names.map { |genre_name| Genre.find_or_create_by(name: genre_name) }
        song = Song.find_or_create_by(name: song_name, artist: artist, genres: genres)

        flash[:message] = "Successfully created song."
        redirect "/songs/#{song.slug}"
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])

        song_name = params[:song][:name]
        artist_name = params[:song][:artist_name]
        genre_names = params[:song][:genre_names]

        artist = Artist.find_or_create_by(name: artist_name)
        genres = genre_names.map { |genre_name| Genre.find_or_create_by(name: genre_name) }
        
        song.update(name: song_name, artist: artist, genres: genres)

        flash[:message] = "Successfully updated song."
        redirect "/songs/#{song.slug}"
    end

    delete '/songs/:slug' do
        song = Song.find_by_slug(params[:slug])
        song.destroy
        flash[:message] = "Successfully deleted song."
        redirect "/songs"
    end

end
