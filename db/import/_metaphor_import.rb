# TODO See below todo about adding work id check against those dupes deleted during import to maintain referencial
# integrity.
require File.dirname(__FILE__) + '/../../config/environment'
#require 'nokogiri'
require 'hpricot'

# Read the duplicate work infor into a hash
#duplicate_works = {}
#File.open("db/import/duplicate_works.txt","r") do |file|
#  while line = file.gets
#    (key,value) = line.chomp.split(/,/)
#    duplicate_works[key] = value
#  end
#end
#puts duplicate_works.inspect
#w = Work.find_by_id(duplicate_works["3401"].to_i)
#puts w.inspect
#exit

# A class to hold each of the old work record data elements
class TempMetaphor
  
  include HappyMapper
  
  tag 'metaphor'
  
  element :id, Integer, :tag=>'MetaphorID'
  element :work_id, Integer, :tag=>'WorkID'
  element :metaphor, String, :tag=>'Metaphor'
  element :text, String, :tag=>'Text'
  element :category, String, :tag=>'Category'
  element :sub_category, String, :tag=>'SubCategory'
  element :context, String, :tag=>'Context'
  element :provenance, String, :tag=>'Provenance'
  element :date_of_entry, String, :tag=>'DoE'
  element :date_of_review, String, :tag=>'DoR'
  element :sub_sub_category, String, :tag=>'SSCategory'
  element :type, String, :tag=>'Type'
  element :theme, String, :tag=>'Theme'
  element :comments, String, :tag=>'Comments'
  element :dictionary, String, :tag=>'Dictionary'
end

# load up the xml data
xml_data = File.read("db/import/metaphors.xml")

class MI 
  attr_reader :id, :work_id, :metaphor, :text, :category, :sub_category, :context, :provenance, :date_of_entry 
  attr_reader :date_of_review, :sub_sub_category, :type, :theme, :comments, :dictionary
  def initialize(metaphor_xml)
    @id = metaphor_xml.at('MetaphorID').inner_text.to_i
     @work_id = metaphor_xml.at('WorkID').inner_text.to_i
     @metaphor = metaphor_xml.at('Metaphor').inner_text
     @text = metaphor_xml.at('Text').inner_text
     @category = metaphor_xml.at('Category').inner_text
     @sub_category = metaphor_xml.at('SubCategory').inner_text
     @context = metaphor_xml.at('Context').inner_text
     @provenance = metaphor_xml.at('Provenance').inner_text
     @date_of_entry = metaphor_xml.at('DoE').inner_text
     @date_of_review = metaphor_xml.at('DoR').inner_text
     @sub_sub_category = metaphor_xml.at('SSCategory').inner_text
     @type = metaphor_xml.at('Type').inner_text
     @theme = metaphor_xml.at('Theme').inner_text
     @comments = metaphor_xml.at('Comments').inner_text
     @dictionary = metaphor_xml.at('Dictionary').inner_text
     #puts @text
  end
end

class M
  attr :xml
  def initialize(data)
    @xml = Hpricot::XML(data)
#    @xml = Nokogiri::XML(data)
#    @xml = Nokogiri::XML::Document.parse(data,'','utf-8')
  end
  def each
    @xml.search('//metaphor').each_with_index do |m,i|
      #puts m.inner_html
      yield MI.new(m)
      #break if i >50
    end
  end
end

# Create temporary work objects from the XML data
#temp_metaphors = TempMetaphor.parse(xml_data)
temp_metaphors = M.new(xml_data)

# Go through each metaphor and add the unique occurrences to the database
last_metaphor = Metaphor.new(:metaphor => '')
#i = 0
temp_metaphors.each do |t|
  #puts i
  #i += 1
  # Per Brad, metaphor should not be empty. So ignore empty values.
  if (t.metaphor != '')
    # Create a new metaphor if it didn't just get added.
    if (t.metaphor != last_metaphor.metaphor)
      begin
        metaphor = Metaphor.new(:metaphor => t.metaphor) do |m|
          m.id = t.id
          # TODO The work number should be compared to a list of works that were deleted
          # from the work import because they were duplicates. Then replacing that deleted
          # work number with the one that was used. This should be implemented after the
          # work import script is updated to handle this.
          m.work = Work.find_by_id(t.work_id)
#          if (m.work == nil)
#            m.work = Work.find_by_id(duplicate_works[t.work_id.to_s])
#          end
          m.text = t.text
          m.context = t.context
          m.provenance = t.provenance
          m.created_at = t.date_of_entry
          m.updated_at = t.date_of_review
          m.theme = t.theme
          m.comments = t.comments
          m.dictionary = t.dictionary
        end
        if (t.category != '')
          c = t.category
          if (t.sub_category != '')
            c += '::' + t.sub_category
            if (t.sub_sub_category != '')
              c += '::' + t.sub_sub_category
            end
          end
          metaphor.categories.build(:value => c)
        end
        if (t.type != '')
          metaphor.types.build(:name => t.type)
        end
        metaphor.save
      rescue
        puts 'Problem with MetaphorID ' + t.id.to_s
        metaphor.errors.each do |attr, msg|
          puts 'Metaphor error: ' + attr + ' - ' + msg
        end
      end
    else
      # This indicates that we have a duplicate metaphor which could indicate that there are additional
      # categories associated with it OR another type OR additional comments, etc. So we need to update
      # the last metaphor with additional information.
      begin
        if (t.category != '')
          c = t.category
          if (t.sub_category != '')
            c += '::' + t.sub_category
            if (t.sub_sub_category != '')
              c += '::' + t.sub_sub_category
            end
          end
          last_metaphor.categories.build(:value => c)
        end
        if ((t.theme != '') && (last_metaphor.theme.index(t.theme) == nil))
          last_metaphor.theme += ' ' + t.theme
        end
        if ((t.comments != '') && (last_metaphor.comments.index(t.comments) == nil))
          last_metaphor.comments += ' ' + t.comments
        end
        if ((t.dictionary != '') && (last_metaphor.dictionary.index(t.dictionary) == nil))
          last_metaphor.dictionary += ' ' + t.dictionary
        end
        if ((t.type != '') && (last_metaphor.types.index(t.type) == nil))
          last_metaphor.types.build(:name => t.type)
        end
        last_metaphor.save
      rescue
        puts 'Problem with duplicate metaphor, MetaphorID ' + t.id.to_s
        puts 'Last metaphor id ' + last_metaphor.id.to_s
        last_metaphor.errors.each do |attr, msg|
          puts 'Metaphor error: ' + attr + ' - ' + msg
        end
      end
    end
  end
  if (metaphor)
    last_metaphor = metaphor
  end
end