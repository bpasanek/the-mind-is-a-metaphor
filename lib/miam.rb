# module for containing "config" type objects
module MIAM
  
  mattr_accessor :solr_url
  self.solr_url = 'http://localhost:8983/solr'
  
  # returns a solr instance/singleton
  def self.solr
    @solr ||= (
      c = RSolr::Ext.connect(:url=>MIAM.solr_url)
      #c.adapter.connector.adapter_name = :net_http
      
    )
  end
  
end