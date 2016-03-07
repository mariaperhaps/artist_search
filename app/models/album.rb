class Album < ActiveRecord::Base
  has_many :songs
  belongs_to :artist

  def self.search(term, index, results)
    albums = Album.includes([:songs, :artist]).where('lower(name) = ?', term.join(" ").downcase)
    if albums != [] && index > 0
      results = []
    end
      albums.each do |album|
            album_result = {
                             artist: album.artist,
                             album: album,
                             songs: album.songs
                          }
            results.push(album_result)
      end
      results
  end

end
