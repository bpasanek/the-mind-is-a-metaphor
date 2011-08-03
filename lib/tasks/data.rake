ENV ||= {}

namespace :data do
  
  desc 'Imports the original data from the db/import/*_import.rb scripts'
  task :import_original=>:environment do
    ENV['NO_INDEX'] = 'true'
    s = Time.now
    [:nationality, :occupation, :politic, :religion, :author, :author_work, :work, :metaphor].each do |script_name|
      script = File.join(RAILS_ROOT, 'db', 'import', "#{script_name}_import.rb")
      puts "** Importing data using the #{script_name} import script"
      begin
        require script
      rescue
        puts "** ERROR: #{$!}"
      end
    end
    puts "** Complete... Import time: #{Time.now - s}"
  end
  
  desc 'Synchronizes the DB with Solr'
  task :index=>:environment do
    Metaphor.all.each{|m|m.save}
  end
  
  desc 'Creates a gzipped tarbal for the servers'
  task :package_index => :environment do
    # create a nice file name of yyyy.mm.dd.tar.gz
    fname = Time.now.strftime("%Y.%m.%d.tar.gz")
    command = "tar zcvf ../../#{fname} *"
    
    chdir('solr/solr') do
      sh %{tar zcvf ../../#{fname} data}
    end
  end
  
end