class Admin::BaseController < ApplicationController
  before_filter :authenticate_user!

  def render_ga?
    false
  end
end
