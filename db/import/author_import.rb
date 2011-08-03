fields =  %W(id name gender date_of_birth date_of_death occupation_id religion_id politic_id nationality_id notes)
CsvToDb.go!(Author, fields, 'db/import/authors.csv') do |record, row|
  # skip rows that only have 0's for values
  next if row[0] == '0' and row[1] == '0'
  begin
    Author.find(record.id)
  rescue
    # skip existing records...
    next if Author.find_by_name(record.name)
    record.gender = 'Unknown' if record.gender.empty?
    CsvToDb.save_with_logging record
  end
end