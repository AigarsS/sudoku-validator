# frozen_string_literal: true

class ResultsFormatter
  RESULT_OUTPUT_MAP = {
    valid: 'Sudoku is valid.',
    invalid: 'Sudoku is invalid.',
    incomplete: 'Sudoku is valid but incomplete.'
  }.freeze

  private_constant :RESULT_OUTPUT_MAP

  class << self
    def formatted_result(result)
      RESULT_OUTPUT_MAP[result]
    end
  end
end
