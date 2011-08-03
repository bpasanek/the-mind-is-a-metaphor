module Admin::WorksHelper
  # If a new metaphor record is being created or a metaphor has no categories defined for it
  # then create a new empty category instance for it so that the form can show a nested field on 
  # the form.
  def setup_work(work)
    returning(work) do |w|
      w.genres.build if w.genres.empty?
    end
  end
end