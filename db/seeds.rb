artists = ["failure", "radiohead", "fugazi", "hole", "the orwells", "nirvana", "smashing pumpkins", "tool", "portishead", "Jawbox"]

# Make Albums
def make_albums(albums, artist_id)
  albums.each do |album|
    id = album["id"]
    release_date = HTTParty.get("https://api.spotify.com/v1/albums/#{id}")["release_date"]
    if !Album.exists?(name: album["name"] )
      new_album = Album.create({name: album["name"], release_date: release_date, image_url: album["images"][0]["url"], artist_id: artist_id})
      song_response = HTTParty.get("https://api.spotify.com/v1/albums/#{id}/tracks")
      songs = song_response["items"]
      make_songs(songs, artist_id, new_album)
    end
  end
end

# make songs
def make_songs(songs, artist_id, album)
  songs.each do |song|
    song = Song.create({name: song["name"], track_number: song["track_number"], preview_url: song["preview_url"], artist_id: artist_id, album_id: album.id})
  end
end

# Make Artists
artists.each do |artist|
  response = HTTParty.get("https://api.spotify.com/v1/search?q=#{artist}&type=artist&limit=2")
  artist_id = response["artists"]["items"][0]["id"]
  artist = Artist.create({name: response["artists"]["items"][0]["name"], image_url: response["artists"]["items"][0]["images"][0]["url"]})
  album_response = HTTParty.get("https://api.spotify.com/v1/artists/#{artist_id}/albums")
  albums = album_response["items"]
  make_albums(albums, artist.id)
end



#albums_songs
