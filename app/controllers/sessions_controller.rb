class SessionsController < ApplicationController
  skip_before_action :require_sign_in!, only: [:new, :create]
  before_action :set_user, only: [:create]

  def new
  end

  def create
    if @user.authenticate(session_params[:password])
      sign_in(@user)
      flash[:success] = t 'sessions.login.success'
      redirect_to root_path
    else
      flash[:failed] = t 'sessions.login.failed'
      render 'new'
    end

  end

  def destroy
    sign_out
    flash[:success] = t 'sessions.logout.success'
    redirect_to login_path
  end

  private
    def set_user
      @user = User.find_by!(email: session_params[:email])
    rescue
      flash[:failed] = t 'sessions.login.failed'
      render action: 'new'
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
