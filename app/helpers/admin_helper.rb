# Methods added to this helper will be available to all templates in the admin area.
module AdminHelper
  
  def group_selection_list_for(class_name)
    GroupSelectionList.new(class_name).select_list
  end
  
  # joins the work title and year on a ,
  # throws out blank values
  def work_title_label(work)
    [work.title, work.year].reject{|v|v.to_s.empty?}.join(', ')
  end
  
  def section_select_opt(val,label)
    selected = "/#{params[:controller]}" == val
    %(<option value="#{val}" #{selected ? 'selected="selected"' : ''}">#{label}</option>)
  end
  
  def section_select_opts
    html = section_select_opt(admin_authors_path, 'Authors')
    html << section_select_opt(admin_nationalities_path, '-- Nationalities')
    html << section_select_opt(admin_occupations_path, '-- Occupations')
    html << section_select_opt(admin_politics_path, '-- Politics')
    html << section_select_opt(admin_religions_path, '-- Religions')
    html << section_select_opt(admin_works_path, 'Works')
    html << section_select_opt(admin_metaphors_path, 'Metaphors')
    html << section_select_opt(admin_types_path, '-- Types')
    html << section_select_opt(root_path, 'View Public Site')
  end
  
  def section_title
    @section_title ||= (
      params[:controller].sub(/^admin\//,'').humanize + '/' + params[:action].humanize
    )
  end
  
end