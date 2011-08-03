require 'csv'

# model field => csv column index

fields = {
  :id => 0,
  :title => 1,
  :year => 2,
  :year_integer => 3,
  :printer => 4,
  :place_of_publication =>5,
  :citation => 8,
  :composed => 9,
  :notes => 10
}

CsvToDb.go!(Work, fields, 'db/import/works.csv') do |record,row|
  CsvToDb.save_with_logging record
  path = row.slice(6..7).select{|v|!v.empty?}.join('::')
  genre = record.genres.build(:value => path)
  CsvToDb.save_with_logging genre
end