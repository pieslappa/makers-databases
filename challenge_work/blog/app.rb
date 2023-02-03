require_relative './lib/database_connection.rb'
require_relative './lib/post_repository.rb'

class Application
  def initialize(database_name, io, post_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @post_repository = post_repository
  end

  def run
    @io.puts "Which post would you like to see?"
    post_id = gets.chomp
    post = @post_repository.find_with_comments(post_id)
    comments = post.comments
    @io.puts "Post #{post.id} - #{post.title}"
    @io.puts "Contents: #{post.content}"
    @io.puts "-- Comments --"
    comments.each do |record|
      @io.puts "Comment: #{record.content} by #{record.author}"
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'challenge_blog',
    Kernel,
    PostRepository.new
  )
  app.run
end