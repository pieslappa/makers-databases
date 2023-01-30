# {{TABLE NAME}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```

Table: albums

Columns:
id | title | release_year | artist_id


Table: artists

Columns:
id | name | genre
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Michael Jackson', 'Pop');
INSERT INTO artists (name, genre) VALUES ('Eagles', 'Rock');

INSERT INTO albums (title, release_year, artist_id) VALUES ('Thriller', '1982', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Bad', '1987', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Hotel California', '1976', '2');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: albums

# Model class
# in lib/albums.rb
class Album
end

# Repository class
# in lib/student_repository.rb
class AlbumRepositry
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby

# Table name: albums

# Model class
# (in lib/albums.rb)

class Album

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: albums

# Repository class
# (in lib/album_repository.rb)

class AlbumRepositry

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of Album objects.
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all students

repo = StudentRepository.new

students = repo.all

students.length # =>  2

students[0].id # =>  1
students[0].name # =>  'David'
students[0].cohort_name # =>  'April 2022'

students[1].id # =>  2
students[1].name # =>  'Anna'
students[1].cohort_name # =>  'May 2022'

# 1
# Get all the albums

repo = AlbumRepositry.new

albums = repo.all

albums.length # =>  2

album.first.title # =>  'Thriller'
album.first.release_year # =>  '1982'
album.first.artist_id # => 1

album.first.title # =>  'Hotel California'
album.first.release_year # =>  '1976'
album.first.artist_id # => 2

# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_albums_table
  seed_sql = File.read('spec/seeds_albums.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe AlbumRepositry do
  before(:each) do 
    reset_albums_table
  end

  # (your tests will go here).
  it "returns 3 albums" do
    repo = AlbumRepositry.new
    albums = repo.all

    expect(albums.length).to eq 2
    expect(album.first.title).to eq 'Thriller' 
    expect(album.first.release_year).to eq '1982' 
    expect(album.first.artist_id).to eq 1
  end

  it "returns 1 for artist_id" do
    repo = AlbumRepositry.new
    result = repo.find(1)

    expect(result.id).to eq 1 
    expect(result.title).to eq 'Thriller' 
    expect(album.release_year).to eq '1982' 
    expect(album.artist_id).to eq '1'
  end

end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._