class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist

  def self.search(term, index, results)
    songs = Song.includes(:artist).where('lower(name) = ?', term.join(" ").downcase)
    if songs != [] && index > 0
      results = []
    end
    songs.each do |song|
      song_result = {
                       artist: song.artist,
                       album: song.album,
                       songs: song.album.songs
                    }
      results.push(song_result)
    end
    results
  end


end
