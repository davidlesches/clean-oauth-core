class SessionsController < ApplicationController

  def new
  end

  def create
    if request.env["omniauth.auth"].present?

      oauth = OAuthUser.new(request.env["omniauth.auth"], current_user)
      oauth.login_or_create
      session[:user_id] = oauth.user.id
      redirect_to root_path

    else
      user = RegularUser.find_by_email(params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        session[:user_id]    = user.id
        redirect_to root_path

      else
        flash.now[:error] = "Invalid login credentials."
        render action: 'new'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end