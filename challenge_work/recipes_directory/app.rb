require_relative './lib/database_connection.rb'
require_relative './lib/recipe_repository.rb'

DatabaseConnection.connect('recipes_directory')

recipe_repository = RecipeRepository.new

p recipe_repository.all

p recipe_repository.find(1)