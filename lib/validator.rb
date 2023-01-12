# frozen_string_literal: true

require_relative 'sudoku_validation_service'
require_relative 'results_formatter'

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @matrix = @puzzle_string.scan(/\d/).map(&:to_i).each_slice(9).to_a
    validation_result = SudokuValidationService.validate_sudoku_puzzle(@matrix)
    ResultsFormatter.formatted_result(validation_result)
  end
end
