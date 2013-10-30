RailsAdmin.config do |config|
  config.authorize_with do |controller|
    unless current_user.admin?
      flash[:error] = "You are not an admin"
      redirect_to root_path
    end
  end

  config.model 'AudioVideo' do
    edit do
      configure :slug do
        hide
      end
      configure :status, :enum do
        enum do
          AudioVideo::STATUSES
        end
      end
    end
  end

  config.model 'User' do
    edit do
      configure :confirmation_token do
        hide
      end
      configure :unconfirmed_email do
        hide
      end
    end
  end
end
