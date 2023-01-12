class Validator
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
    return false unless @matrix.flatten.size == 81

    [@matrix, @matrix.transpose, quadrant_matrix].all?(&method(:unique_all_elements?))
  end

  def quadrant_matrix
    @matrix
      .flatten.each_slice(3).each_slice(3).to_a
      .transpose.flatten.each_slice(9).to_a
  end

  def complete?
    @matrix.flatten.none?(&:zero?)
  end

  def unique_all_elements?(matrix)
    matrix.all?(&method(:unique?))
  end

  def unique?(array_to_compare)
    array = array_to_compare.reject(&:zero?)
    array & array == array
  end
end
