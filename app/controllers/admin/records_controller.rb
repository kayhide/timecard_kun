class Admin::RecordsController < AdminController
  before_action :set_user
  before_action :set_record, only: [:update, :destroy]
  before_action :set_cour

  # GET /admin/records
  def index
    @records = @user&.records || Record.includes(:user)
    @records = @records
                 .cour(@cour)
                 .order(started_at: :asc, user_id: :asc)
  end

  # POST /admin/records.js
  def create
    @record = Record.new(record_params)
    @record.finished_at ||= Time.current
    @record.save!
  end

  # PATCH/PUT /admin/records/1.js
  def update
    @record.update!(record_params)
  end

  # DELETE /admin/records/1.js
  def destroy
    @record.destroy
  end

  private
  def set_record
    @record = Record.find(params[:id])
  end

  def set_user
    user_id = params[:user_id]
    @user = User.find(user_id) if user_id
  end

  def record_params
    ps = params.key?(:user_id) ?
           params.slice(:user_id).merge(params[:record]&.permit!) :
           params.require(:record)
    ps.permit(:user_id, :started_at, :finished_at, :started_on, :dateless_started_at, :dateless_finished_at)
  end
end
