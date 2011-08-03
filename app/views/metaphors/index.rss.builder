xml.instruct! :xml, :version=>"1.0"
xml.rss :version=>"2.0" do
  xml.channel do
    xml.title "Mind is a Metaphor"
    xml.description "Metaphors Database by Brad Pasanek"
    xml.link metaphors_url
  
    @solr_response.docs.each do |doc|
      xml.item do
        xml.title truncate(doc[:metaphor], :length=> 300)
        xml.description "Work: #{doc[:work_title]}"
        xml.link metaphor_url(doc[:id])
        xml.guid metaphor_url(doc[:id])
      end
    end
  end
end