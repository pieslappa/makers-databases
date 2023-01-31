require_relative 'lib/database_connection.rb'
require_relative 'lib/book_repositry.rb'

DatabaseConnection.connect('book_store')

sql = 'SELECT id, title, author_name FROM books;'
result_set = DatabaseConnection.exec_params(sql, [])

books = BookRepositry.new

puts books.all