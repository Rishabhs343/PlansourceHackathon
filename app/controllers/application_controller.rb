# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :authenticate_with_token
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def authenticate_with_token
    if params[:api_token]
      user = User.find_by_api_token(params[:api_token])
      sign_in(user)
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[emp_id email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
