require_relative './concerns/slugifiable'

class Genre < ActiveRecord::Base
    extend Slug::ClassMethods
    include Slug::InstanceMethods

    
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs
    #has_many :artists
end