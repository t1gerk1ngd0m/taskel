class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :require_sign_in!
  helper_method :signed_in?

  def authenticate_admin_user!
    render_404 unless current_user.admin?
  end

  def current_user
    remember_token = User.encrypt(cookies[:user_remember_token])
    @current_user = User.find_by(remember_token: remember_token) if @current_user.blank?
    @current_user
  end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def sign_out
    cookies.delete(:user_remember_token)
  end

  def signed_in?
    current_user.present?
  end

  private
  def require_sign_in!
    redirect_to login_path unless signed_in?
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: 'application'
  end

  def render_422
    render file: "#{Rails.root}/public/422.html", status: 422, layout: 'application'
  end

  def render_500
    render file: "#{Rails.root}/public/500.html", status: 500, layout: 'application'
  end
end
