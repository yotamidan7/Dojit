require 'paginate'

module ApplicationHelper

  def form_group_tag(errors)
    if errors.any?
      'form-group has-error'
    else
      'form-group has-error'
    end
  end

  def will_paginate(object, batch_count, curr_page)

    if batch_count > 0

      current_uri = request.env['PATH_INFO']
      @curr_path = Rails.application.routes.recognize_path(current_uri)
      path = @curr_path 
      
      return_text = "<ul class=\"pagination\"><li>"

      # Previous page
      if curr_page.to_i != 0 

        path[:page] = (curr_page.to_i - 1).to_s
        return_text += link_to "<-- Previous", path
        return_text += "</li>"
      end  

      # Page numbers 
      (batch_count + 1).times do |i|

        if i.to_i == curr_page.to_i
          return_text += "<li class=\"active\">"
        else 
          return_text += "<li>"
        end

        path[:page] = i.to_s

        return_text += link_to (i + 1).to_s, path
        return_text += "</li>"   
      end

      # Next page
      if curr_page.to_i != batch_count.to_i

        path[:page] = (curr_page.to_i + 1).to_s

        return_text += "<li>"
        return_text += link_to "Next -->", path
        return_text += "</li>"
      end

      return_text += "</ul>"
      return_text.html_safe
    end

  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
