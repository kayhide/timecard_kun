class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_cour, only: [:show]

  # GET /admin/users
  def index
    @users = User.page
  end

  # GET /admin/users/1
  def show
    @records = @user.records.cour(@cour).order(created_at: :desc)
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to [:admin, :users], notice: t('messages.was_created', item: @user)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      redirect_to [:admin,:users], notice: t('messages.was_updated', item: @user)
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to [:admin, :users], notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
