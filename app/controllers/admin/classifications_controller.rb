class Admin::ClassificationsController < AdminController
  
  resource_controller
  #belongs_to :metaphor, :work
  
  include Searchable
  
  index.wants.json { render :json=>collection.to_json(:only=>[:value]) }
  
  def collection
    if params[:prefix]
      @collection ||= (
        end_of_association_chain.find_all_with_prefix(params[:prefix], params[:limit])
      )
    else
      super
    end
  end
  
  #See http://railscasts.com/episodes/154-polymorphic-association
  def create
    @classifiable = find_classifiable
    @classify = @classifiable.classifications.build(params[:classification])
    if (@classify.save)
      flash[:notice] = "Successfully created classification."
      redirect_to :id => nil
    else 
      render :action => 'new'
    end
  end
  
  private
  
  def find_classifiable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
