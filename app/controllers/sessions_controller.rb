class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else  
        flash[:warning] = "Your Bloggo has not been activated, #{user.name}. Better check your email for a Bloggo link"
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password, so BP Bloggo says "YOU SHALL NOT PASS"'
    render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
