CsvToDb.go!(AuthorWork, %W(author_id work_id), 'db/import/author_works.csv') do |record,row|
  c = {:author_id => record.author_id, :work_id => record.work_id}
  unless AuthorWork.all(:conditions=>c).empty?
    puts "Skipping existing AuthorWork..."
    next
  end
  CsvToDb.save_with_logging record
end