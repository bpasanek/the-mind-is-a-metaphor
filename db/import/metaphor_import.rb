# make sure the metaphors don't index themselves to solr right now...
SolrObserver.indexing = false

# model feild => csv column number
fields = {
  :id=>0, 
  :work_id=>1,
  :metaphor=>2,
  :text=>3,
  :context=>6,
  :provenance=>7,
  :created_at=>8,
  :reviewed_on=>9,
  :theme=>12,
  :comments=>13,
  :dictionary=>14
}

CsvToDb.go!(Metaphor, fields, 'db/import/metaphors.csv') do |record,row|
  
  if ! record.save and record.errors[:metaphor] == 'has already been taken'
    puts "Trying to find existing metaphor..."
    record = Metaphor.find_by_metaphor(record[:metaphor])
    puts "FOUND? #{record}"
    next unless record
  end
  
  CsvToDb.save_with_logging record
  
  # Category
  path = row.slice(4..5).push(row[10]).select{|v|!v.to_s.empty?}.join('::')
  # Category
  cat = record.categories.build(:value => path)
  CsvToDb.save_with_logging cat
  # Type
  type = record.types.build(:name => row[11])
  CsvToDb.save_with_logging type
end