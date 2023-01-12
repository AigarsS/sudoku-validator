# frozen_string_literal: true

class SudokuValidationService
  VALID_DIGITS = [*0..9].freeze
  VALID_SIZE = 81

  private_constant :VALID_SIZE, :VALID_DIGITS

  def initialize(sudoku_matrix)
    @sudoku_matrix = sudoku_matrix
  end

  def self.validate_sudoku_puzzle(sudoku_matrix)
    new(sudoku_matrix).validate
  end

  def validate
    return :invalid unless sudoku_valid?
    return :incomplete unless complete?

    :valid
  end

  private

  def sudoku_valid?
    return false unless valid_symbols_and_size?

    [@sudoku_matrix, @sudoku_matrix.transpose, quadrant_matrix].all?(&method(:unique_all_elements?))
  end

  def valid_symbols_and_size?
    flat_matrix = @sudoku_matrix.flatten

    flat_matrix.size == VALID_SIZE &&
      flat_matrix.all? { |element| VALID_DIGITS.include?(element) }
  end

  def quadrant_matrix
    @sudoku_matrix
      .flatten.each_slice(3).each_slice(3).to_a
      .transpose.flatten.each_slice(9).to_a
  end

  def complete?
    @sudoku_matrix.flatten.none?(&:zero?)
  end

  def unique_all_elements?(matrix)
    matrix.all?(&method(:unique?))
  end

  def unique?(array_to_compare)
    array = array_to_compare.reject(&:zero?)
    array & array == array
  end
end
