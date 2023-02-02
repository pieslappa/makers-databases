require_relative 'lib/database_connection.rb'
require_relative 'lib/book_repository.rb'

DatabaseConnection.connect('book_store')

sql = 'SELECT id, title, author_name FROM books;'
result_set = DatabaseConnection.exec_params(sql, [])

books = BookRepository.new

puts books.all