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



end
