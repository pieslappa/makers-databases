require_relative 'lib/database_connection'
require_relative 'lib/album_repository.rb'
require_relative 'lib/artist_repository.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
album_repository = AlbumRepository.new
artist_repository = ArtistRepository.new

# Print out each record from the result set .
# album_repository.all.each do |album|
#   p album
# end

# artist_repository.all.each do |artist|
#   p artist
# end



p album_repository.find(3)
