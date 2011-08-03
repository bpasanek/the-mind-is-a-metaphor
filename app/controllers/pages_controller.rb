class PagesController < ApplicationController
  
  # GET handler for arbitrary "static" pages
  def render_page
    tpl = File.join(Rails.root, 'app', 'views', 'pages', "#{params[:id]}.html.erb")
    if File.exists?(tpl)
      render(:template=>tpl)
    else
      render(:text=>'404 Not Found')
    end
  end
  
end