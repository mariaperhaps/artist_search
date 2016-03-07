require 'rails_helper'
require 'pry'

describe Artist do

  before do
    @artist = Artist.create(name: "Object")
    @album = Album.create(name: "Tomorrowland", artist_id: @artist.id)
    @song = Song.create(name: "Just For You", artist_id: @artist.id, album_id: @album.id)
  end

  describe "ActiveRecord associations" do
    it  "should have many albums" do
      expect(@artist.albums.class).to eq(Album::ActiveRecord_Associations_CollectionProxy)
      expect(@artist.albums[0][:name]).to eq("Tomorrowland")
    end

   it  "should have many songs" do
      # expect(@artist.songs.class).to eq(Song::ActiveRecord_Associations_CollectionProxy)
      expect(@artist.songs[0][:name]).to eq("Just For You")
    end
  end


  describe "#search" do

    it "should return a results Array" do
      expect(Artist.search("Object").class).to eq(Array)
    end

    it "should return a Song, Artist, and Album object" do
      expect(Artist.search("Object")[0][:artist].class).to eq(Artist)
      expect(Artist.search("Just For You")[0][:songs][0].class).to eq(Song)
      expect(Artist.search("Tomorrowland")[0][:album].class).to eq(Album)
    end

    it "should return a specific album if an album and an artist are searched" do
      album = Artist.search("Object Tomorrowland")[0][:album][:name]
      expect(album).to eq("Tomorrowland")
    end

    it "should return the album of a song if a song and an artist are searched" do

    end

  end

end
