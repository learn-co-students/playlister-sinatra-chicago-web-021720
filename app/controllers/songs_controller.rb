require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash
    #displays all songs
    get '/songs' do 
        @songs = Song.all
        erb :'songs/index'
    end

    #route after new song is created
    post '/songs' do 
        @song = Song.new(name: params[:song])
        artist = Artist.find_or_create_by(name: params[:artist])
        @song.artist = artist
        params[:genres].each do |id|
            genre = Genre.find(id)
            #SongGenre.create(song: song, genre: genre)
            @song.genres << genre
        end
        @song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end

    #displays the create new form
    get '/songs/new' do 
        @genres = Genre.all

        erb :'songs/new'
    end 

    #display individual song
    get '/songs/:slug' do 
        @song = Song.find_by_slug(params[:slug])

        erb :'songs/show'
    end

    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params[:slug])
        @genres= Genre.all
        erb :'songs/edit'
    end 

    #route after the song is edited
    patch '/songs/:slug' do 
        song = Song.find_by_slug(params[:slug])
        art = Artist.find_or_create_by(name: params[:artist])
        song.artist = art
        song.song_genres.each {|sg| sg.destroy}
        params[:genres].each do |id|
            genre = Genre.find(id)
            
            song.genres << genre
        end

         song.save
         flash[:message] = "Successfully updated song."
         redirect "songs/#{song.slug}"
    end

    #route after song instance is deleted
    delete '/songs/:slug' do 
        
        redirect '/songs'
    end

end