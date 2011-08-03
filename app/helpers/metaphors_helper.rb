module MetaphorsHelper
  
  # returns an ordered list of fields to use for the facets menu.
  def facet_fields
    %W(work_literary_period categories work_genres author_gender author_nationality author_politic author_religion)
  end
  
  # adds the value and/or field to params[:f]
  def add_facet_param(field, value)
    p = params.dup
    return p if p[:f] and p[:f][field] and p[:f][field].include?(value)
    p.delete :page
    p.delete :id
    p.delete :action
    p[:f]||={}
    p[:f][field] ||= []
    p[:f][field] << value
    p
  end
  
  # copies the current params
  # removes the field value from params[:f]
  # removes the field if there are no more values in params[:f][field]
  # removes the :page param
  def remove_facet_param(field, value)
    p=params.dup
    p.delete :page
    if p[:f] and p[:f][field]
      if p[:f][field].empty?
        p[:f].delete field
      elsif p[:f][field].include?(value)
        p[:f][field] -= [value]
      end
    end
    p
  end
  
  # true or false, depending on wether the field and value is in params[:f]
  def facet_in_params?(field, value)
    params[:f] and params[:f][field] and params[:f][field.to_s].include?(value.to_s)
  end
  
  # pass in a facet field name (solr field name)
  # returns a labelized/normalized facet label
  def facet_label(facet_name)
    labels = {
      'work_literary_period' => 'Literary Period',
      'author_gender' => 'Gender of Author',
      'author_occupation' => 'Occupation of Author',
      'author_nationality' => 'Nationality of Author',
      'author_politic' => 'Politics of Author',
      'author_religion' => 'Religion of Author',
      'work_genres' => 'Genre',
      'categories' => 'Metaphor Category'
    }
    labels[facet_name] || facet_name.humanize
  end
  
  # for use in a paginated result set.
  # converts the index of an item in a x-per-page result set
  # to a 1-per-page result-set value
  # using the current_page and per_page settings.
  def calculate_page_from_index_to_show(index)
    ((per_page * @solr_response.docs.current_page) + index + 1) - per_page
  end
  
  # takes the :offset param from the search_item action (1 solr doc per page)
  # and converts it into a value that can be used in the index view
  def calculate_page_from_show_to_index
    (params[:offset].to_f/per_page.to_f).ceil
  end
  
  def options_for_sort
    html=[]
    fields = []
    fields << ['Date, ascending','date']
    fields << ['Date, descending','-date']
    fields << ['Relevance, ascending','relevance']
    fields << ['Relevance, descending','-relevance']
    fields << ['Author, ascending','author']
    fields << ['Author, descending','-author']
    fields.each do |sfield|
			option = option_tag(sfield.last, params[:sort]==sfield.last, :label=>sfield.first.humanize)
			html << option
		end
		html.join
  end
  
  def options_for_per_page
    html = []
    [10,25,100].each do |pp|
			html << option_tag(pp, params[:per_page].to_i==pp)
		end
		html.join
	end
  
end