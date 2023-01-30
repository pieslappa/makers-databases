require_relative '../lib/album_repositry.rb'

RSpec.describe AlbumRepositry do

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_albums_table
  end

  it "returns 3 albums" do  
    repo = AlbumRepositry.new
    albums = repo.all

    expect(albums.length).to eq 3
    expect(albums.first.title).to eq 'Thriller' 
    expect(albums.first.release_year).to eq '1982' 
    expect(albums.first.artist_id).to eq "1"
  end

  it "returns album details for the album inputted" do
    repo = AlbumRepositry.new
    result = repo.find(1)

    expect(result.id).to eq '1' 
    expect(result.title).to eq 'Thriller' 
    expect(result.release_year).to eq '1982' 
    expect(result.artist_id).to eq '1'
  end
end