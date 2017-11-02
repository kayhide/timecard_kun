class ApplicationController < ActionController::Base
  include ErrorHandler

  protect_from_forgery with: :exception
  if ENV['BASIC_AUTH_USERNAME'].present?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  end

  def keep_user_info
    if params[:user_id] && params[:user_name]
      session[:user_id] = params[:user_id]
      session[:user_name] = params[:user_name]
    end
  end

  def user_id
    session[:user_id]
  end
  helper_method :user_id

  def user_name
    session[:user_name]
  end
  helper_method :user_name
end
