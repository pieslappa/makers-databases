require_relative 'artist'
require_relative 'album'

class ArtistRepository
  def all
    artists = []

    sql = 'SELECT id, name, genre FROM artists;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      artist = Artist.new

      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end
    return artists
  end

  def find_with_albums(id)
    sql = 'SELECT artists.id,
                  artists.name,
                  artists.genre,
                  albums.id AS album_id,
                  albums.title,
                  albums.release_year
          FROM artists
          LEFT JOIN albums
          ON albums.artist_id = artists.id
          WHERE artists.id = $1;'
    
    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)

    artist = Artist.new

    artist.id = result_set.first['id']
    artist.name = result_set.first['name']
    artist.genre = result_set.first['genre']

    result_set.each do |record|
      album = Album.new

      album.id = record['album_id']
      album.title = record['title']
      album.release_year = record['release_year']

      artist.albums << album
    end
    return artist
  end
end