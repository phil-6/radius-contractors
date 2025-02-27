class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render "pages/main"
  end
end
