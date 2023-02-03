require_relative './lib/database_connection.rb'
require_relative './lib/album_repository.rb'
require_relative './lib/artist_repository.rb'

class Application
  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts "What would you like to do?"
    @io.puts "1 - List all albums"
    @io.puts "2 - List all arists"

    @io.puts "Enter your choice:"
    choice = @io.gets.chomp

    if choice == "1"
      puts "Here is the list of albums:"
      albums = @album_repository.all
      albums.each do |album|
        puts "* #{album.id} - #{album.title}"
      end
    elsif choice == "2"
      artists = @artist_repository.all
      puts "Here is the list of artists:"
      artists.each do |artist|
        puts "* #{artist.id} - #{artist.name}"
      end
    else
      p "Choice not recognised"
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end
