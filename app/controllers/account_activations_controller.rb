class AccountActivationsController < ApplicationController

  def edit 
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Big Papi Bloggo activated your account. A star shines on the hour of our meeting."
      redirect_to user
    else
      flash[:danger] = "activation link INVALID: BP Bloggo says YOU SHALL NOT PASS"
      redirect_to root_url
    end
  end
end
