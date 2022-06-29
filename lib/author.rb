require './lib/book'
require 'pry'

class Author

  attr_reader :first_name,
              :last_name,
              :books

  def initialize(author)
    @first_name = author[:first_name]
    @last_name = author[:last_name]
    @books = []
  end

  def name
    "#{first_name} #{last_name}"
  end

  def write(title, publication_date)
    book = Book.new({author_first_name: first_name, author_last_name: last_name,
                      title: title, publication_date: publication_date})
    books << book
    book 
  end





end
