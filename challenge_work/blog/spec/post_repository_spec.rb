require_relative '../lib/post_repository.rb'

RSpec.describe PostRepository do
  it "Returns the data of a post including comments" do
    repo = PostRepository.new
    result = repo.find_with_comments(1)
    expect(result.comments.length).to eq 2
  end
end