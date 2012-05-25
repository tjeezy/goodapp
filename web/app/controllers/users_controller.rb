class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @apps = @user.valid_apps
    @endorsements = @user.endorsements_as_endorsee
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    # TODO less hacky?
    anchor = params[:user][:about] ? "profile-pane" : "account-settings-pane"
    if current_user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated your settings."
      redirect_to settings_path(anchor: anchor)
    else
      flash[:alert] = "There was an issue in updating your settings."
      redirect_to settings_path(anchor: anchor)
    end
  end
end
