require_relative '../lib/recipe_repository'
require_relative '../lib/database_connection.rb'

describe RecipeRepository do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_discovery_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_recipes_table
  end

  it "returns all of the recipes" do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 2 # =>  2

    expect(recipes[0].id).to eq 1
    expect(recipes[0].name).to eq 'Chicken Pie'
    expect(recipes[0].cooking_time).to eq 60 # =>  60
    expect(recipes[0].rating).to eq 4


    expect(recipes[1].id).to eq # =>  2
    expect(recipes[1].name).to eq 'Spaghetti Bolognese'
    expect([1].cooking_time).to eq 30
    expect([1].rating).to eq 5
  end

  it "returns the recipe using the find method" do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    expect(recipe.id).to eq 1
    expect(recipe.name).to eq 'Chicken Pie'
    expect(recipe.cooking_time).to eq 60
    expect(recipe.rating).to eq 4
  end
end