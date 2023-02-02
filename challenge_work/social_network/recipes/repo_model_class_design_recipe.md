## 1. Design and create the Table

```

Table: users

Columns:
id | email_address | username

Table: posts

Columns:
id | title | contents | views | user_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (email_address, username) VALUES ('hello@cleech.uk', 'cdog');
INSERT INTO users (email_address, username) VALUES ('adam@hello.uk', 'adoggydogg');

INSERT INTO posts (title, content, views, user_id) VALUES ('Hello World', 'I just wanted to say hello', 1, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Hello Again', 'I just wanted to say hello again', 5, 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('Hello', 'I also wanted to say hello', 3, 2);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds_social_network.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end


# Table name: posts
# Model class
# (in lib/post.rb)
class User
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: users
# Model class
# (in lib/user.rb)

class Student
  # Replace the attributes by your own columns.
  attr_accessor :id, :email_address, :username
end

# Table name: posts
# Model class
# (in lib/post.rb)

class Student
  attr_accessor :id, :title, :content, :views, :user_id
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: users

# Repository class
# (in lib/student_repository.rb)

class UserRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM users WHERE id = $1;

    # Returns a single User object.
  end

  def create(user)
    # user is an instance of User
    # Executes the SQL query:
    # INSERT INTO users (email_address, username) VALUES ($1, $2)

    # Returns nothing
  end

  def delete(id)
    # takes the id of a user to be deleted as an argument
    # Executes the SQL query:
    # DELETE FROM users WHERE id = $1

    # Returns nothing
  end
end

class PostRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM users;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_id FROM users WHERE id = $1;

    # Returns a single Post object.
  end

  def create(post)
    # user is an instance of User
    # Executes the SQL query:
    # INSERT INTO users (title, content, views, user_id) VALUES ($1, $2, $3, $4)

    # Returns nothing
  end

  def delete(id)
    # takes the id of a user to be deleted as an argument
    # Executes the SQL query:
    # DELETE FROM posts WHERE id = $1

    # Returns nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all users

repo = UserRepository.new

users = repo.all

expect(users.length).to eq 2
expect(users[0].id).to eq 1
expect(users[1].id).to eq 2

# 2
# Get a single user

repo = UserRepository.new

user = repo.find(1)

expect(user.id).to eq 1
expect(user.email_address).to eq 'hello@cleech.uk'
expect(user.username).to eq 'cdog'


# 3
# Create a new user

repo = UserRepository.new

user = User.new
user.email_address = 'ben@ben.com'
user.username = 'bendog'

repo.create(user)

users = repo.all

expect(repo.length).to eq 3


# 4
# Delete a user

repo = UserRepository.new

repo.delete(2)

users = repo.all

expect(users.length).to eq 1

# 5
# List all posts
repo = PostRepository.new

posts = repo.all

expect(posts.length).to eq 3
expect(posts[0].id).to eq 1
expect(posts[1].id).to eq 2


# 6
# Find a post
repo = PostRepository.new

post = repo.find(1)

expect(post.id).to eq 1


# 7
# Create a post
repo = PostRepository.new

post = Post.new
post.title = "Favourite food"
post.content = "Everything"
post.views = 10
post.user_id = 1

post.create(post)

posts = post.all

expect(posts.length).to eq 4


# 8
# Delete a post
repo = PostRepository.new

repo.delete(1)

posts = repo.all
expect(posts.length).to eq 2
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

describe UserRepository do
  def reset_users_table
    seed_sql = File.read('spec/seeds_social_network.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_users_table
  end

  it "Gets all users" do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq 2
    expect(users[0].id).to eq 1
    expect(users[1].id).to eq 2
  end

  it "Finds a specific user" do
    repo = UserRepository.new
    user = repo.find(1)
    expect(user.id).to eq 1
    expect(user.email_address).to eq 'hello@cleech.uk'
    expect(user.username).to eq 'cdog'
  end

  it "Creates a new user" do
    repo = UserRepository.new
    user = User.new
    user.email_address = 'ben@ben.com'
    user.username = 'bendog'
    repo.create(user)
    users = repo.all
    expect(repo.length).to eq 3
  end

  it "Deletes a given user" do
    repo = UserRepository.new
    repo.delete(2)
    users = repo.all
    expect(users.length).to eq 1
  end
end

Describe PostRepository do
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
    expect(posts[0].id).to eq 1
    expect(posts[1].id).to eq 2
  end

  it "returns a given post" do
    repo = PostRepository.new
    post = repo.find(1)
    expect(post.id).to eq 1
  end

  it "creates a new post" do
    repo = PostRepository.new
    post = Post.new
    post.title = "Favourite food"
    post.content = "Everything"
    post.views = 10
    post.user_id = 1
    post.create(post)
    posts = post.all
    expect(posts.length).to eq 4
  end

  it "deletes a given post" do
    repo = PostRepository.new
    repo.delete(1)
    posts = repo.all
    expect(posts.length).to eq 2
  end
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._