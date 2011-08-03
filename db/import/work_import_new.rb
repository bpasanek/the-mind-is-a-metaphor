require 'csv'
#"WorkID","Title","Year","YearInt","Printer","PlacePub","Genre","SubGenre","Citation","Composed","Notes"
parsed_file = CSV::Reader.parse(File.read('db/import/works.csv')) do |row|
  record = Work.new({
    :id => row[0],
    :title => row[1],
    :year => row[2],
    :year_integer => row[3],
    :printer => row[4],
    :place_of_publication => row[5],
    :citation => row[8],
    :composed => row[9],
    :notes => row[10]
  })
  
  puts record.save
  
  path = row.slice(6..7).select{|v|!v.empty?}.join('::')
     
  genre = record.genres.build({
      :value => path
  })
      
   genre.save
   
end

