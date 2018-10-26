require_relative "album"

class Collection

  def initialize
    @albums = Array.new()
  end

  def get_album(title)
    @albums.find {|album| album.title == title}
  end

  def add(item)
	# adds album (create instance of Album and add to @albums collection)
	if item[0] && item[1]
	  existingAlbum = self.get_album(item[0])
	  if (existingAlbum)
		puts "An album with that name already exists. Please try again."
	  else
		album = Album.new(item[0], item[1])
		@albums << album
		puts "Added " + album.display_text(false)
		return album
	  end
    else
	  raise 'error'
    end
  end

  def play(item)
    # plays album (render title and set played to true)
    if item[0]
	  album = self.get_album(item[0])
	  if album
	    puts "You're listening to \"#{album.title}\""
	    album.played = true
	  else
	    puts "Album not found! Please try again."
	  end
	else
	  raise 'error'
	end
  end

  def display_albums(albums, show_played_status)
	# render requested albums
	if albums.length > 0
	  albums.map do |album|
		puts album.display_text(show_played_status)
	  end
    else
	  puts "No albums found!"
    end
  end

  def get_all_albums(item)
	# generic getter function
	if (item)
	  return @albums.select {|album| album.artist == item[0]}
    else
  	  return @albums
    end
  end

  def get_unplayed_albums(item)
	# generic getter function
	if (item)
      return @albums.select {|album| (album.artist == item[0] && !album.played)}
    else
	  return @albums.select {|album| !album.played}
	end
  end

  def show_all(item)
	# requests albums from getter and passes them to render
	albums = get_all_albums(nil)
	display_albums(albums, true) # second argument toggles rendering of played status
  end

  def show_all_by(item)
	# requests albums from getter and passes them to render
	albums = get_all_albums(item)
	display_albums(albums, true)
  end

  def show_unplayed(item)
	# requests albums from getter and passes them to render
	albums = get_unplayed_albums(nil)
	display_albums(albums, false)
  end

  def show_unplayed_by(item)
	# requests albums from getter and passes them to render
	albums = get_unplayed_albums(item)
	display_albums(albums, false)
  end

end
