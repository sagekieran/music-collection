require_relative "models/collection"

class Music

  def initialize
    @collection = Collection.new()
  end

  def run
	display_welcome
	get_input
  end

  def display_welcome
    puts "Welcome to your music collection!"
  end

  def get_input
	# requests input from user
	input = gets.chomp
	begin
	  cleaned_input = clean_input(input)
	  dispatch_command(cleaned_input)
    rescue
      # in case user enters empty string or other invalid characters
	  puts 'Input can not be parsed. Please enter a valid command.'
	  get_input
    end
  end

  def clean_input(input)
	# separate command from album in user input
	input  = input.split('"').select{ |item| (item != " ") }
	action = input[0].split(" ").join("_")
	item   = input.drop(1)
	return {action: action, item: item}
  end

  def dispatch_command(input)
    begin
	  @collection.send(input[:action], input[:item]) # checks if command is a method on Collection
    rescue
	  begin
    	send(input[:action], input[:item]) # checks if command is a method on Music (i.e. "quit")
      rescue
    	puts 'Error occured, please check your last command and try again.' # rescue if command doesnt exist
	  end
    end
	get_input
  end

  def quit(input)
    puts "Bye!"
	exit
  end

end

music = Music.new
music.run
