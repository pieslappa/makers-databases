require_relative 'lib/database_connection'
require_relative 'lib/album_repositry.rb'
require_relative 'lib/artist_repositry.rb'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
album_repositry = AlbumRepositry.new
artist_repositry = ArtistRepositry.new

# Print out each record from the result set .
# album_repositry.all.each do |album|
#   p album
# end

# artist_repositry.all.each do |artist|
#   p artist
# end



p album_repositry.find(3)
