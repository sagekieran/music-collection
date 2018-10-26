Dir["models/*.rb"].each do |file|
  require_relative file
end
require "test/unit"

class TestMusic < Test::Unit::TestCase

  def test_create_album
    album = Album.new("title", "artist")
    assert_equal("title",  album.title)
  end

  def test_get_all_albums
    collection = Collection.new
    5.times.map do |index|
      collection.add(["album"+index.to_s, "artist"])
    end

    assert_equal(5, collection.get_all_albums(nil).length)
  end

  def test_get_albums_by_artist
      collection = Collection.new
      collection.add(["album1", "artist1"])
      collection.add(["album2", "artist2"])
      collection.add(["album3", "artist1"])
      collection.add(["album4", "artist1"])

      assert_equal(3, collection.get_all_albums("artist1").length)
  end

  def test_get_unplayed_albums
      collection = Collection.new
      collection.add(["album01", "artist0"])
      collection.add(["album02", "artist1"])
      collection.add(["album03", "artist2"])
      6.times.map do |index|
        album = collection.add(["album"+index.to_s, "artist0"])
        album.played = true
      end

      assert_equal(1, collection.get_unplayed_albums("artist0").length) # unplayed by artist0
      assert_equal(7, collection.get_all_albums("artist0").length) # all by artist0
      assert_equal(3, collection.get_unplayed_albums(nil).length) # unplayed by all artists
      assert_equal(9, collection.get_all_albums(nil).length) # all by all artists
  end

end
