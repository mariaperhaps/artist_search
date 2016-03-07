class Artist < ActiveRecord::Base
  has_many :albums
  has_many :songs

  def self.get_combos(query)
    terms = query.split(" ")
    possible_combos = []
    terms.each_with_index do |term, index|
      combos = terms.combination(index + 1).to_a
      combos.each { |combo| possible_combos.push(combo)}
    end
    possible_combos
  end

  def self.search(q)
    possible_combos = get_combos(q)
    results = []
    possible_combos.each_with_index do |term, index|
      artist = Artist.includes([:songs, :albums]).find_by('lower(name) = ?', term.join(" ").downcase)
        if artist != nil
           artist.albums.each do |album|
            artist_result = {
                             artist: artist,
                             album: album,
                             songs: album.songs
                          }
            results.push(artist_result)
          end
        end
        results = Album.search(term, index, results)
        results = Song.search(term, index, results)
    end
        results
  end

end
