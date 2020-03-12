require_relative './concerns/slugifiable.rb'
class Artist < ActiveRecord::Base
    include Slugifiable::Instance
    extend Slugifiable::Class

    has_many :songs
    has_many :song_genres, through: :songs
    has_many :genres, through: :song_genres

    
end 