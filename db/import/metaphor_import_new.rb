require 'csv'
#  0            1        2          3      4          5             6         7            8     9     10           11     12      13         14
#"MetaphorID","WorkID","Metaphor","Text","Category","SubCategory","Context","Provenance","DoE","DoR","SSCategory","Type","Theme","Comments","Dictionary"

puts "Metaphors: "

index = 0
parsed_file = CSV::Reader.parse(File.read('db/import/metaphors.csv')) do |row|
  record = Metaphor.new({
    :id => row[0],
    
    :metaphor => row[2],
    :text => row[3],
    :context => row[6],
    :provenance => row[7],
    :created_at => row[8],
    :updated_at => row[9],
    :theme => row[12],
    :comments => row[13],
    :dictionary => row[14]
  })
  
  record.save
  
  #TODO: get row 10 too
  path = row.slice(6..7).select{|v|!v.empty?}.join('::')
      
  categories = record.categories.build({
    :value => path
  })
  
      
  categories.save
  
  types = record.types.build({
    :name => row[10]
  })
  
  types.save
  index++
  puts "#{index}" 
  
end