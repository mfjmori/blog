module ApplicationHelper

  def truncate_content_article_index
    if params[:controller] == 'articles' && params[:action] == 'show'
      nil
    else
      "hide"
    end
  end

  def hoverable_article_index
    if params[:controller] == 'articles' && params[:action] == 'show'
      nil
    else
      "hoverable"
    end
  end
end
