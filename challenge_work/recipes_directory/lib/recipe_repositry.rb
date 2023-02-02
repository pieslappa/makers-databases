require_relative './database_connection.rb'
require_relative './recipe.rb'

class RecipeRepository
  def all
    recipes = []

    sql = 'SELECT id, name, cooking_time, rating FROM recipes;'
    result_set = DatabaseConnection.exec_params(sql, [])

    result_set.each do |record|
      recipe = Recipe.new

      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']

      recipes << recipe
    end
    return recipes
  end

  def find(id)
    sql = 'SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;'
    params = [id]

    result_set = DatabaseConnection.exec_params(sql, params)

    result_set.map do |record|
      recipe = Recipe.new
      recipe.id = record['id']
      recipe.name = record['name']
      recipe.cooking_time = record['cooking_time']
      recipe.rating = record['rating']
      return recipe
    end
  end
end
      