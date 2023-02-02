
## 1. Design and create the Table

```
Table: recipes

Columns:
name | cooking_time | rating
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_recipes.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE recipes RESTART IDENTITY;


INSERT INTO recipes (name, cooking_time, rating) VALUES ('Chicken Pie', 60, 4);
INSERT INTO recipes (name, cooking_time, rating) VALUES ('Spaghetti Bolognese', 30, 5);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_recipes.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: recipes

# Model class
# (in lib/recipe.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repositry.rb)
class RecipeRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cooking_time, :rating
end
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: recipes

# Repository class
# (in lib/recipe_repositry.rb)

class RecipeRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cooking_time, rating FROM recipes;

    # Returns an array of Recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cooking_time, rating FROM recipes WHERE id = $1;

    # Returns a single Recipe object.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all recipes

repo = RecipeRepositry.new

recipes = repo.all

recipes.length # =>  2

recipes[0].id # =>  1
recipes[0].name # =>  'Chicken Pie'
recipes[0].cooking_time # =>  60
recipes[0].rating # =>  4


recipes[1].id # =>  2
recipes[1].name # =>  'Spaghetti Bolognese'
recipes[1].cooking_time # =>  30
recipes[1].rating # =>  5

# 2
# Get a single student

repo = RecipeRepositry.new

recipe = repo.find(1)

recipe.id # =>  1
recipe.name # =>  'Chicken Pie'
recipe.cooking_time # =>  60
recipe.rating # =>  4

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repositry_spec.rb

describe RecipeRepositry do
  def reset_recipes_table
    seed_sql = File.read('spec/seeds_recipes.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_recipes_table
  end

  it "returns all of the recipes" do
    repo = RecipeRepositry.new

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
    repo = RecipeRepositry.new

    recipe = repo.find(1)

    expect(recipe.id).to eq 1
    expect(recipe.name).to eq 'Chicken Pie'
    expect(recipe.cooking_time).to eq 60
    expect(recipe.rating).to eq 4
  end
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._