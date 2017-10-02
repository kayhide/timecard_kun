class Admin::Users::HiddenController < Admin::UsersController
  before_action :set_user, only: [:create, :destroy]

  # PUT /admin/users/1/hidden
  def create
    @user.update hidden: true
    render action: :update
  end

  # DELETE /admin/users/1/hidden
  def destroy
    @user.update hidden: false
    render action: :update
  end
end
