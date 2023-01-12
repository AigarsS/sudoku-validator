require 'pry'

class Validator
  PARSED_ARRAY_SIZE = 81

  private_constant :PARSED_ARRAY_SIZE

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @matrix = @puzzle_string.scan(/\d/).map(&:to_i).each_slice(9).to_a
    "#{formatted_result.join(' ')}."
  end

  private

  def formatted_result
    result = ['Sudoku is']
    return result << 'invalid' unless sudoku_valid?

    result << 'valid'
    result << 'but incomplete' unless complete?
    result
  end

  def sudoku_valid?
    return false unless @matrix.flatten.size == PARSED_ARRAY_SIZE

    [@matrix, @matrix.transpose].all?(&method(:unique_elements?))
  end

  def complete?
    @matrix.flatten.none?(&:zero?)
  end

  def unique_elements?(matrix)
    matrix.all?(&method(:uniq?))
  end

  def uniq?(array_to_compare)
    array = array_to_compare.reject(&:zero?)
    array & array == array
  end
end
