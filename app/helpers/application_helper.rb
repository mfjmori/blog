module ApplicationHelper

  def active_controller_and_action
    if params[:controller] == 'articles' && params[:action] == 'index'
      "hide"
    elsif params[:controller] == 'users' && params[:action] == 'show'
      "hide"
    else
      nil
    end
  end
end
