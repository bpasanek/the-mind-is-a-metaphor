#require 'csv'
require 'faster_csv'

class CsvToDb
  
  # calls save on an object
  # "logs" the result
  def self.save_with_logging(obj)
    if obj.save
      puts "Saved #{obj.class} ##{obj.id} OK"
    else
      puts "Saved #{obj.class} Failed #{obj.errors.map{|e|e}.join(': ')}"
    end
  end
  
  # The go! method accepts a "model_class" that should have a corresponding CSV file.
  # The "fields" is an array OR hash of model attributes and must map to the CSV head column indexes
  #   - if a Hash is used, the key is the model field, the value is the csv column index.
  # "csv_file" is the path to the CSV file.
  # go! also accepts a block and yields the new instance and CSV data row.
  def self.go!(model_class, fields, csv_file, &blk)
    line = -1
    #CSV::Reader.parse(File.read(csv_file)) do |row|
    FasterCSV.foreach(csv_file) do |row|
      line += 1
      next if line==0
      
      new_data = {}
      
      # inject the csv data into "new_data"
      
      # Hash
      if fields.respond_to?(:each_pair)
        fields.each_pair {|name, i| new_data[name.to_s] = row[i]}
      else
      # Array
        fields.each_with_index {|name, i| new_data[name.to_s] = row[i]}
      end
      
      begin
        model_class.find(new_data['id'])
        puts "This object (#{model_class}) already exists... skipping"
      rescue
        new_object = model_class.new(new_data) do |obj|
          obj.id = new_data['id']
        end
        if block_given?
          yield new_object, row
        else
          save_with_logging new_object
        end
      end
      
    end
    
  end

end