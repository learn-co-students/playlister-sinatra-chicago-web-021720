require_relative './concerns/slugifiable.rb'

class SongGenre < ActiveRecord::Base
    include Slugifiable::Instance
    extend Slugifiable::Class

belongs_to :song
belongs_to :genre
has_one :artist, through: :song
end