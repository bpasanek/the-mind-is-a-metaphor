module Admin::MetaphorsHelper
  
  # If a new metaphor record is being created or a metaphor has no categories defined for it
  # then create a new empty category instance for it so that the form can show a nested field on 
  # the form.
  def setup_metaphor(metaphor)
    returning(metaphor) do |m|
      m.categories.build if m.categories.empty?
      m.types.build if m.types.empty?
    end
  end
end