require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/library'

class LibraryTest < Minitest::Test

  def test_if_it_exists
    dpl = Library.new("Denver Public Library")

    assert_instance_of Library, dpl
  end

  def test_if_it_has_attributes
    dpl = Library.new("Denver Public Library")

    assert_equal "Denver Public Library", dpl.name
    assert_equal [], dpl.books
    assert_equal [], dpl.authors
  end

  def test_if_it_has_authors
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal [charlotte_bronte, harper_lee], dpl.authors
    assert_instance_of Book, dpl.books.first
    assert_equal [jane_eyre, professor, villette, mockingbird], dpl.books
    assert_equal 4, dpl.books.count
  end

  def test_if_it_has_publication_time_frame
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    charlotte_bronte.write("The Professor", "1857")
    charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal ({:start=>"1847", :end=>"1857"}), dpl.publication_time_frame_for(charlotte_bronte)
    assert_equal ({:start=>"1960", :end=>"1960"}), dpl.publication_time_frame_for(harper_lee)
  end

  def test_if_a_book_is_not_in_library
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    refute dpl.checkout(mockingbird) #This book doesn't exist in library
    refute dpl.checkout(jane_eyre) #This book doesn't exist in library
    refute dpl.checkout(villette) #This book doesn't exist in library
  end

  def test_if_a_book_in_the_library_can_be_checked_out
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert dpl.checkout(jane_eyre)
    assert_equal [jane_eyre], dpl.checked_out_books

    refute dpl.checkout(jane_eyre) #This book cannot be checked out as it is alrleady checked out
  end

  def test_if_a_book_can_be_returned
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)
    dpl.checkout(jane_eyre)
    dpl.return(jane_eyre)

    assert_equal [], dpl.checked_out_books
    assert dpl.checkout(jane_eyre)
    assert dpl.checkout(villette)
    assert_equal [jane_eyre, villette], dpl.checked_out_books
  end

end
