class SessionsController < ApplicationController

  # Log in the user
  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Incorrect username/password combination"]
      render :new
    else
      log_in_user!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end

  # Render the login page
  def new
    render :new
  end

end
