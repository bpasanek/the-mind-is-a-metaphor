# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Calls methods on an object chain.
  # Returns the default value if the attribute doesn't exist.
  #
  # Example:
  # <%= value_or_default @author, :religion, :name %>
  # which turns out to be: @author.religion.name
  # - instead of failing when there is no @author.religion,
  # the default value is returned.
  # If the last argument is a string, it's used as the default value.
  def value_or_default(obj, *attrs)
    default = attrs.last.is_a?(String) ? attrs.pop : 'n/a'
    attrs.inject(obj) do |current_obj, attribute|
      current_obj.respond_to?(attribute) ? current_obj.send(attribute) : default
    end
  end
  
  def option_tag(value,selected,opts={})
    opts[:selected] = 'selected' if selected
    opts[:label] ||= value
    opts[:value] ||= value
    content_tag :option, opts[:label], opts
  end
  
end