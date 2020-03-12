class SongsController < ApplicationController
    
    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    get '/songs/new' do
        erb :'songs/new'
    end

    get '/songs/:slug/edit' do
        p params
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    get '/songs/:slug' do
        p params
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    post '/songs' do
        p params
        @artist = Artist.find_or_create_by(name: params[:song][:artist])
        @song = Song.create(name: params[:song][:name], artist_id: @artist.id)
        params[:song]["genre"].keys.each do |key|
            SongGenre.create(song_id: @song.id, genre_id: key)
        end
        redirect "/songs/#{@song.slug}"
    end

    patch '/songs/:slug' do
        p params
        Song.find_by_slug(params[:slug]).update(params)
        redirect "/songs/#{@song.slug}"
    end

end