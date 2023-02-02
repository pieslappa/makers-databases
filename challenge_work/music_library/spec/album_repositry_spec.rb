require_relative '../lib/album_repository.rb'

RSpec.describe AlbumRepository do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
  end

  it "returns 3 albums" do  
    repo = AlbumRepository.new
    albums = repo.all

    expect(albums.length).to eq 3
    expect(albums.first.title).to eq 'Thriller' 
    expect(albums.first.release_year).to eq '1982' 
    expect(albums.first.artist_id).to eq "1"
  end

  it "returns album details for the album inputted" do
    repo = AlbumRepository.new
    result = repo.find(1)

    expect(result.id).to eq '1' 
    expect(result.title).to eq 'Thriller' 
    expect(result.release_year).to eq '1982' 
    expect(result.artist_id).to eq '1'
  end

  it "adds a given album" do
    repo = AlbumRepository.new
    
    album = Album.new
    album.title = 'Dangerous'
    album.release_year = 1991
    album.artist_id = 1

    repo.create(album)

    all_albums = repo.all

    expect(all_albums.length).to eq 4
  end

  it "deletes a given album" do
    repo = AlbumRepository.new
    repo.delete(1)
    all_albums = repo.all
    expect(all_albums.length).to eq 2
  end
end