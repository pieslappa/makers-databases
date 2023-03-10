require_relative '../lib/artist_repository.rb'

RSpec.describe ArtistRepository do

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_artists_table
  end

  it "returns 2 artists" do  
    repo = ArtistRepository.new
    artists = repo.all

    expect(artists.length).to eq 2
    expect(artists.first.id).to eq '1'
    expect(artists.first.name).to eq 'Michael Jackson' 
    expect(artists.first.genre).to eq 'Pop' 
  end

  it 'finds 1 artist with related albums' do
    repo = ArtistRepository.new
    artist = repo.find_with_albums(1)

    expect(artist.name).to eq 'Michael Jackson'
    expect(artist.albums.length).to eq 1
  end
end