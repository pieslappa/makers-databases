require_relative '../lib/book_repository.rb'

RSpec.describe BookRepository do
  def reset_books_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_books_table
  end

  it "returns a printed list of all books" do
    books = BookRepository.new
    expect(books.all).to eq "1 - Emma - Jane Austen\\n2 - Dracula - Bram Stoker"
  end
end