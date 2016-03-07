require 'rails_helper'
require 'pry'

describe Song do

  before do
    @artist = Artist.create(name: "Object")
    @album = Album.create(name: "Tomorrowland", artist_id: @artist.id)
    @song = Song.create(name: "Just For You", artist_id: @artist.id, album_id: @album.id)
  end

  describe "ActiveRecord associations" do
    it  "should belong to an artist" do
      expect(@song.artist.name).to eq("Object")
    end

    it  "should belong to an album" do
      expect(@song.album.name).to eq("Tomorrowland")
    end
  end

  describe "#search" do
    it("should return an song") do
      results = []
      expect(Song.search(["Just For You"], 0, results)[0][:songs][0].class).to eq(Song)
      expect(Song.search(["Just For You"], 0, results)[0][:songs][0][:name]).to eq("Just For You")
    end
  end

end
