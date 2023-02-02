require_relative './lib/database_connection.rb'
require_relative './lib/user_repository.rb'
require_relative './lib/post_repository.rb'

DatabaseConnection.connect('social_network')

user_repository = UserRepository.new
post_repository = PostRepository.new

user_repository.find(1)