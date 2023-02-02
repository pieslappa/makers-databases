require_relative './lib/database_connection.rb'
require_relative './lib/recipe_repositry.rb'

DatabaseConnection.connect('recipes_directory')

recipe_repositry = RecipeRepositry.new

p recipe_repositry.all

p recipe_repositry.find(1)