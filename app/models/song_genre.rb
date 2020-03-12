require_relative './concerns/slugifiable'

class SongGenre < ActiveRecord::Base
    
    include Slug

    belongs_to :song
    belongs_to :genre
end
