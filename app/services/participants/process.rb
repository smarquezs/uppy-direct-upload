require 'roo'

module Participants
  class Process
    def initialize(url)
      @url = url
    end

    def to_a
      xls = read_excel_file
      results = []

      3.upto(xls.last_row) do |row|
         results << {
          rut:        xls.cell(row, "A"),
          name1:      xls.cell(row, "B"),
          name2:      xls.cell(row, "C"),
          last_name1: xls.cell(row, "D"),
          last_name2: xls.cell(row, "E"),
          role:       xls.cell(row, "F"),
          email:      xls.cell(row, "G"),
          mobile:     xls.cell(row, "H"),
        }
      end

      results
    end

    private

    attr_reader :url

    def read_excel_file
      xls = Roo::Spreadsheet.open(url)
      xls.default_sheet = xls.sheets.first
      xls
    end
  end
end
