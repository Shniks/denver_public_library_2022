require './lib/author'

class Library

  attr_reader :name,
              :books,
              :authors,
              :checked_out_books,
              :checked_out_numbers

  def initialize(library)
    @name = library
    @books = []
    @authors = []
    @checked_out_books = []
    @checked_out_numbers = Hash.new(0)
  end

  def add_author(author)
    authors << author
    add_books(author)
  end

  def add_books(author)
    author.books.each do |book|
      books << book
    end
  end

  def publication_time_frame_for(author)
    years = get_publication_years(author)
    {:start => years.min.to_s, :end => years.max.to_s}
  end

  def get_publication_years(author)
    author.books.map do |book|
      book.publication_year.to_i
    end
  end

  def checkout(book)
    is_book_checked_out?(book)
  end

  def is_book_checked_out?(book) # Can this method be refactored and simplified?
    if books.include?(book)
      books.delete(book)
      checked_out_books << book
      checked_out_numbers[book] += 1
      return true
    else
      return false
    end
  end

  def return(book)
    books << book
    checked_out_books.delete(book)
  end

  def most_popular_book
    checked_out_numbers.max_by { |book, value| value }.first
  end

end
