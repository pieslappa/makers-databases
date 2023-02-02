require_relative '../lib/post_repository.rb'

describe PostRepository do
  def reset_posts_table
    seed_sql = File.read('spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_posts_table
  end

  it "returns all posts" do
    repo = PostRepository.new
    posts = repo.all
    expect(posts.length).to eq 3
    expect(posts[0].id).to eq "1"
    expect(posts[1].id).to eq "2"
  end

  it "returns a given post" do
    repo = PostRepository.new
    post = repo.find(1)
    expect(post.id).to eq "1"
  end

  it "creates a new post" do
    repo = PostRepository.new
    post = Post.new
    post.title = "Favourite food"
    post.content = "Everything"
    post.views = 10
    post.user_id = "1"
    repo.create(post)
    posts = repo.all
    expect(posts.length).to eq 4
  end

  it "deletes a given post" do
    repo = PostRepository.new
    repo.delete(1)
    posts = repo.all
    expect(posts.length).to eq 2
  end
end