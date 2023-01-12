class Validator
  VALID_SUDOKU_SIZE = 81

  RESULT_OUTPUT = {
    valid: 'Sudoku is valid.',
    invalid: 'Sudoku is invalid.',
    incomplete: 'Sudoku is valid but incomplete.'
  }.freeze

  private_constant :VALID_SUDOKU_SIZE, :RESULT_OUTPUT

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @matrix = @puzzle_string.scan(/\d/).map(&:to_i).each_slice(9).to_a

    RESULT_OUTPUT[validation_result]
  end

  private

  def validation_result
    return :invalid unless sudoku_valid?
    return :incomplete unless complete?

    :valid
  end

  def sudoku_valid?
    return false unless @matrix.flatten.size == VALID_SUDOKU_SIZE

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
