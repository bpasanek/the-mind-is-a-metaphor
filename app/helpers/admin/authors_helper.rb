module Admin::AuthorsHelper
  
  # array of gender labels
  def gender_list
    Author.genders
  end
  
  # returns an array useful for sending to the #select view helper
  def occupation_list
    Occupation.all_ordered.map {|o| [o.name, o.id]}
  end
  
  # returns an array useful for sending to the #select view helper
  # Takes a class object.
  # Returns an array where each item is another array,
  # where the first value is the label and the second the value.
  # -- this was created for the #select form helper.
  # The "class_object" should respond_to?(:all_ordered),
  # which must return an array of objects.
  # Each object should have
  # :grouping and :name attributes.
  def list_with_group(class_object)
    class_object.all_ordered.map do |r|
      label_items = [r.grouping, r.name].compact
      [label_items.join(' > '), r.id]
    end
  end
  
  # returns an array useful for sending to the #select view helper
  # calls #list_with_group with Religion
  def religion_list
    list_with_group Religion
  end
  
  # returns an array useful for sending to the #select view helper
  # calls #list_with_group with Politic
  def politic_list
    list_with_group Politic
  end
  
  # returns an array useful for sending to the #select view helper
  def nationality_list
    Nationality.all_ordered.map {|n| [n.name, n.id]}
  end
  
  # returns an array useful for sending to the #select view helper
  def work_list
    Work.all_ordered.map {|w| [w.title, w.id]}
  end
  
end