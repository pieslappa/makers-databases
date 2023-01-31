require_relative './book'

class BookRepositry
  def all
    sql = 'SELECT id, title, author_name FROM books;'
    result_set = DatabaseConnection.exec_params(sql, [])
    
    books = []

    result_set.map do |record|
      book = Book.new

      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']

      books << "#{book.id} - #{book.title} - #{book.author_name}" 
    end
    books.join('\n')
    return books
  end
end