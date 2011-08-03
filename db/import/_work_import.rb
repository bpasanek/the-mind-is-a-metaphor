# Used to import the tab delimited file exported from the original MySQL database
# structure for the PHP based site.
require File.dirname(__FILE__) + '/../../config/environment'
require 'hpricot'

# A class to hold each of the old work record data elements
class TempWork
  include HappyMapper
  
  tag 'work'
  element :id, Integer, :tag=>'WorkID'
  element :title, String, :tag=>'Title'
  element :year, String, :tag=>'Year'
  element :year_integer, Integer, :tag=>'YearInt'
  element :printer, String, :tag=>'Printer'
  element :place_of_publication, String, :tag=>'PlacePub'
  element :genre, String, :tag=>'Genre'
  element :sub_genre, String, :tag=>'SubGenre'
  element :citation, String, :tag=>'Citation'
  element :composed, String, :tag=>'Composed'
  element :notes, String, :tag=>'Notes'
end

# Open duplicate works file to reset it to be empty
#open("db/import/duplicate_works.txt","w") {|f| }

# Load the xml data file into a string
xml_data = File.read("db/import/works.xml")

class WI 
  attr_reader :id, :title, :year, :year_integer, :printer, :place_of_publication, :genre, :sub_genre, :citation 
  attr_reader :composed, :notes
  def initialize(work_xml)
    @id = work_xml.at('WorkID').inner_text.to_i
    @title = work_xml.at('Title').inner_text
    @year = work_xml.at('Year').inner_text
    @year_integer = work_xml.at('YearInt').inner_text.to_i
    @printer = work_xml.at('Printer').inner_text
    @place_of_publication = work_xml.at('PlacePub').inner_text
    @genre = work_xml.at('Genre').inner_text 
    @sub_genre = work_xml.at('SubGenre').inner_text
    @citation = work_xml.at('Citation').inner_text
    @composed = work_xml.at('Composed').inner_text
    @notes = work_xml.at('Notes').inner_text
    #puts @title
  end
end

class W
  attr :xml
  def initialize(data)
    @xml = Hpricot::XML(data)
  end
  def each
    @xml.search('//work').each_with_index do |w,i|
      #puts m.inner_html
      yield WI.new(w)
      #break if i >50
    end
  end
end

# Create temporary work objects from the XML data
#temp_works = TempWork.parse(xml_data)
temp_works = W.new(xml_data)

# Go through each work record and add it into the database.
#last_work = Work.new(:title => '')
temp_works.each do |t|
  # Create the new work record
  # Remember that Title Not Known does not apply as a duplicate work
#  if ((t.title.index("Title Not Known") != nil) || (t.title != last_work.title))
    begin
      work = Work.new(:title => t.title) do |w|
        w.id = t.id
        w.year = t.year
        w.year_integer = t.year_integer
        w.printer = t.printer
        w.place_of_publication = t.place_of_publication
        w.citation = t.citation
        w.composed = t.composed
        w.notes = t.notes
      end
      if (t.genre != '')
        g = t.genre
        if (t.sub_genre != '')
          g = g + '::' + t.sub_genre
        end
        work.genres.build(:value => g)
      end
      work.save
#      last_work = work
    rescue
      puts 'Problem with WorkID ' + t.id.to_s
      work.errors.each do |attr, msg|
        puts 'Work error: ' + attr + ' - ' + msg
      end
    end
#  else 
    # NOTE: This indicates that we have a duplicate work in the old data.
    # But the genre information may not be the same so create a new one.
#    begin
#      if (t.genre != '')
#        g = t.genre
#        if (t.sub_genre != '')
#          g = g + '::' + t.sub_genre
#        end
#        last_work.genres.build(:value => g)
#      end
#      if ((t.year != '') && (last_work.year.index(t.year) == nil))
#        last_work.year += ' ' + t.year
#      end
#      if ((t.printer != '') && (last_work.printer.index(t.printer) == nil))
#        last_work.printer += ' ' + t.printer
#      end
#      if ((t.year_integer != 0) && (last_work.year_integer == 0))
#        last_work.year_integer = t.year_integer
#      end
#      if ((t.place_of_publication != '') && (last_work.place_of_publication.index(t.place_of_publication) == nil))
#        last_work.place_of_publication += ' ' + t.place_of_publication
#      end
#      if ((t.citation != '') && (last_work.citation.index(t.citation) == nil))
#        last_work.citation += ' ' + t.citation
#      end
#      if ((t.composed != '') && (last_work.composed.index(t.composed) == nil))
#        last_work.composed += ' ' + t.composed
#      end
#      if ((t.notes != '') && (last_work.notes.index(t.notes) == nil))
#        last_work.notes += ' ' + t.notes
#      end
#      last_work.save
#    rescue
#      puts 'Problem with duplicate work, WorkID ' + t.id.to_s
#      puts 'Last work id ' + last_work.id.to_s
#      last_work.errors.each do |attr, msg|
#        puts 'Work error: ' + attr + ' - ' + msg
#      end
#    end

    
    # Find the author_work record for this work so that we can drop it
#    author_work = AuthorWork.find_by_work_id(t.id)
#    if (author_work)
#      begin
        # write the duplicate work id being deleted followed by the work id that should be used in its place.
        # this needs to be done before we delete the record from the author_works table
#        open("db/import/duplicate_works.txt","a")  { |f| f.puts t.id.to_s + "," + last_work.id.to_s }
#        begin
#          author_work.delete
#        rescue
#          puts 'Problem deleting duplicate work from author_works for duplicate work ID ' + t.id.to_s
#        end
#      rescue
#        puts 'Problem writing to duplicate_works.txt: ' + t.id.to_s + "," + last_work.id.to_s
#      end
#    end
#  end
end
