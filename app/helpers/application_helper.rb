module ApplicationHelper
  def controller_name
    params[:controller].gsub(/\W/, "-")
  end

  def display_return_to_proposal
    controller.is_a?(ProposalsController) && params[:action] == "history"
  end

  def display_return_to_proposals
    controller.is_a?(ClientDataController) ||
      (controller.is_a?(ProposalsController) && params[:action] != "index")
  end

  def auth_path
    "/auth/myusa"
  end

  def display_profile_warning?
    !current_page?(profile_path) && current_user && current_user.requires_profile_attention?
  end

  def display_search_ui?
    current_user && current_user.client_model && !client_disabled?
  end

  def blank_field_default(field)
    if field.blank?
      field = "--".to_s
    end
    field
  end

  def list_view_conditions
    user_condition = (!@current_user.nil? && @current_user.should_see_beta?("BETA_FEATURE_LIST_VIEW"))
    action_condition = (params[:action] == "index" || params[:action] == "show")
    controller_condition = (controller_name == "proposals")
    (controller_condition && action_condition && user_condition)
  end
end
