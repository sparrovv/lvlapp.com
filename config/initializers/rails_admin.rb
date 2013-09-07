RailsAdmin.config do |config|
  config.authorize_with do |controller|
    unless current_user.admin?
      flash[:error] = "You are not an admin"
      redirect_to root_path
    end
  end
end
