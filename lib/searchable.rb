#
# Searchable is a controller mixin for controllers ***that are using resource_controller***
# It provides one method, "collection" which is used by resource_controller.
module Searchable
  
  def collection
    model_class = end_of_association_chain
    find_opts = {
      :page => params[:page],
      :per_page => 10
    }
    wildcard_q = "%#{params[:q]}%"
    # For each kind of model, we point to a sql condition.
    # Tweak this for changing the way the admin search works.
    
    # Metaphor.all(:include=>[:categories], :conditions => ['classifications.value LIKE ?', 'Writing%']).size
    
    if model_class == Metaphor
      find_opts[:include] = [:categories]
    end
    
    condition_mapping = {
      Metaphor => ['metaphor LIKE ? OR comments LIKE ? OR classifications.value LIKE ?', wildcard_q, wildcard_q, wildcard_q],
      Work => ['title LIKE ? OR notes LIKE ?', wildcard_q, wildcard_q],
      Author => ['name LIKE ? OR last_name LIKE ? OR first_name LIKE ?', wildcard_q, wildcard_q, wildcard_q],
      Type => ['name LIKE ?', wildcard_q],
      Politic => ['name LIKE ? OR grouping LIKE ?', wildcard_q, wildcard_q],
      Religion => ['name LIKE ? OR grouping LIKE ?', wildcard_q, wildcard_q],
      Occupation => ['name LIKE ?', wildcard_q],
      Nationality => ['name LIKE ?', wildcard_q],
      Classification => ['value LIKE ?', wildcard_q]
    }
    find_opts[:conditions] = condition_mapping[model_class]
    model_class.paginate(find_opts)
  end
  
=begin
  def collection
    # solr document ids are actually metaphor ids
    # object_name comes from resoure_controller
    id_field = self.object_name == 'metaphor' ? 'id' : "#{object_name}_ids"
    
    @collection ||= (
      q = nil
      sort = params[:sort].blank? ? 'asc' : params[:sort]=='descending' ? 'desc' : 'asc'
      ppage = 10
      page = params[:page]
      # only query solr if the q param has a value
      # the solr fl param only needs to be the object_name id field
      unless params[:q].blank?
        @solr_response = solr.find(
          :qt => :search,
          :q => params[:q],
          :fl => "score, #{id_field}",
          :page => 1,
          :per_page => 10_000_000
        )
        # now collect all of the ids from each solr document
        q = @solr_response.docs.map{|d|d[id_field]}.flatten.compact.uniq
      end
      @q = q
      # push all of the args to the model's #paginate method
      # remove items in the args that are nil
      # :order=>sort
      end_of_association_chain.paginate(*[q, {:order=>"id desc", :page=>page, :per_page=>ppage}].compact)
    )
  end
=end
  
end