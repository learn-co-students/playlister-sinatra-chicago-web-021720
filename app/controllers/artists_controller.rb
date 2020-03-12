class ArtistsController < ApplicationController

    get '/artists' do
        @artists = Artist.all
        erb :'artists/index'
    end

    get '/artists/new' do
        
    end

    get '/artists/:slug/edit' do
    end

    get '/artists/:slug' do
        p params
        @artist = Artist.find_by_slug(params[:slug])
        erb :'artists/show'
    end

end
