require_relative './concerns/slugifiable.rb'
class Genre < ActiveRecord::Base
    include Slugifiable::Instance
    extend Slugifiable::Class

has_many :song_genres
has_many :artists, through: :song_genres
has_many :songs, through: :song_genres
end 