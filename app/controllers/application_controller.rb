class ApplicationController < ActionController::Base
  add_flash_types :error, :info, :warning, :success
  allow_browser versions: :modern
  before_action :authenticate_user!
end
