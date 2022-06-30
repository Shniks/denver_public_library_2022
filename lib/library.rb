require './lib/author'
require 'pry'

class Library

  attr_reader :name,
              :books,
              :authors

  def initialize(library)
    @name = library
    @books = []
    @authors = []
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
    result = {:start => years.min.to_s, :end => years.max.to_s}
  end

  def get_publication_years(author)
    author.books.map do |book|
      book.publication_year.to_i
    end
  end

end
