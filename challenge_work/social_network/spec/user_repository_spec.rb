require_relative '../lib/user_repository.rb'

describe UserRepository do
  def reset_users_table
    seed_sql = File.read('spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_users_table
  end

  it "Gets all users" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq 2
    expect(users[0].id).to eq "1"
    expect(users[1].id).to eq "2"
  end

  it "Finds a specific user" do
    repo = UserRepository.new
    user = repo.find(1)
    expect(user.id).to eq "1"
    expect(user.email_address).to eq 'hello@cleech.uk'
    expect(user.username).to eq 'cdog'
  end

  it "Creates a new user" do
    repo = UserRepository.new
    user = User.new
    user.email_address = 'ben@ben.com'
    user.username = 'bendog'
    repo.create(user)
    users = repo.all
    expect(users.length).to eq 3
  end

  it "Deletes a given user" do
    repo = UserRepository.new
    repo.delete(2)
    users = repo.all
    expect(users.length).to eq 1
  end
end