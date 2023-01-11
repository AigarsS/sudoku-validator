require 'pry'

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @puzzle_integer_array = @puzzle_string.scan(/\d/).map(&:to_i)
    @matrix = @puzzle_integer_array.each_slice(9).to_a

    sudoku_valid?
  end

  private

  def sudoku_valid?
    all_are_digits? && [@matrix, @matrix.transpose].all?(&method(:unique_elements?))
  end

  def unique_elements?(matrix)
    matrix.all?(&method(:uniq?))
  end

  def uniq?(array)
    array & array == array
  end

  def all_are_digits?
    @puzzle_integer_array.all? { |element| [*0..9].include?(element) }
  end
end
