# frozen_string_literal: true

class Validator
  VALID_SIZE = 81

  RESULT_OUTPUT_MAP = {
    valid: 'Sudoku is valid.',
    invalid: 'Sudoku is invalid.',
    incomplete: 'Sudoku is valid but incomplete.'
  }.freeze

  private_constant :RESULT_OUTPUT_MAP, :VALID_SIZE

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @parsed_flat_matrix = @puzzle_string.scan(/\d/).map(&:to_i)

    RESULT_OUTPUT_MAP[validation_result]
  end

  private

  def validation_result
    return :invalid unless valid?
    return :incomplete unless complete?

    :valid
  end

  def valid?
    return false unless @parsed_flat_matrix.size == VALID_SIZE

    sudoku_matrix = @parsed_flat_matrix.each_slice(9).to_a
    [sudoku_matrix, sudoku_matrix.transpose, quadrant_matrix].all?(&method(:unique?))
  end

  def quadrant_matrix
    @parsed_flat_matrix
      .each_slice(3).each_slice(3).to_a
      .transpose.flatten.each_slice(9).to_a
  end

  def unique?(matrix)
    matrix.all? do |row|
      array = row.reject(&:zero?)
      array & array == array
    end
  end

  def complete?
    @parsed_flat_matrix.none?(&:zero?)
  end
end
