class MetaphorsController < ApplicationController
  
  after_filter :sessionize_search_params, :only=>:index
  before_filter :load_prev_next, :only=>:search_item
  
  # expose this method to the views
  helper_method :per_page
  
  # /metaphors
  # the main search action
  def index
    @solr_response = query_solr
    respond_to do |f|
      f.html
      f.rss
      f.csv do
        @metaphors = Metaphor.find(@solr_response.docs.map{|d|d[:id]})
      end
    end
  end
  
  # /metaphors/item/:offset
  # single document action, but still in "search" mode
  def search_item
    @solr_response = query_solr({
      :per_page=>1,
      :page=>current_offset
    }.merge(session[:search]))
    begin
      # redirect back to the search view if this doesn't work out.
      # it's possible that someone could visit
      # with different session values...
      @metaphor = Metaphor.find(@solr_response.docs.first[:id])
    rescue
      return redirect_to(metaphors_path(session[:search]))
    end
    render :template=>'metaphors/show'
  end
  
  # /metaphors/:id
  # single document, fixed id action
  def show
    @metaphor = Metaphor.find(params[:id])
    render(:partial=>'search_result_details') if request.xml_http_request?
  end
  
  protected
  
  # converts the offset param to an integer
  def current_offset
    params[:offset].to_i
  end
  
  # loads a previous and next document based on the 
  def load_prev_next
    offset = current_offset
    @previous_doc = offset > 1 ? single_doc_by_index(offset-1, session[:search]) : nil
    @next_doc = single_doc_by_index(offset+1, session[:search])
  end
  
  # queries solr with a preset set of solr params
  # the :q, :f and :page params are used
  def query_solr(extra_params={})
    solr.find({
      :qt => :search,
      :q => params[:q],
      :phrase_filters => params[:f],
      :per_page => self.per_page,
      :page => params[:page],
      :sort => self.sort_by
    }.merge(extra_params))
  end
  
  def sort_by
    sort = params[:sort].to_s
    sort_dir = sort =~ /^-/ ? 'desc' : 'asc'
    sort_field = case sort.sub(/^-/,'')
    when 'author'
      'author_name'
    when 'date'
      'work_year_sort'
    when 'timestamp'
      'timestamp'
    when 'relevance'
      'score'
    else
      # default to relevance...
      #'score'
      'work_year_sort'
    end
    "#{sort_field} #{sort_dir}" unless sort_field.empty?
  end
  
  # calculates the per_page based on the params[:per_page] value
  def per_page
    v = params[:per_page].to_i
    return 10 if v < 10
    return 100 if v > 100
    v
  end
  
  # returns a single solr doc
  def single_doc_by_index(offset, extra_params={})
    query_solr({
      :per_page=>1,
      :page=>(offset)
      }.deep_merge(extra_params)
    ).docs.first rescue nil
  end
  
  # stores the search params into session[:search]
  def sessionize_search_params
    session[:search] = {}.deep_merge(params)
    valid = ['q', 'page', 'per_page', 'f']
    session[:search].keys.each do |k|
      session[:search].delete(k) unless valid.include?(k)
    end
  end
  
end