class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user=User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
      log_in(@user)
      redirect_to @user
    else
      flash[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end
  
  def destroy
    cookies.delete(:auth_token)
    session[:user_id]=nil
    redirect_to '/'
  end
end
