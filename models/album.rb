class Album
  attr_reader :title, :artist
  attr_accessor :played

  def initialize(title, artist)
	@title  = title
	@artist = artist
	@played = false
  end

  def display_text(show_played_status)
	# builds album information for "show"
	text = "\"#{self.title}\" by #{self.artist}"
	if show_played_status
      played = " (#{self.played ? "played" : "unplayed"})"
    end
	return text + played ||= ""
  end

end
