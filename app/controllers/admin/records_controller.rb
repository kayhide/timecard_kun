class Admin::RecordsController < AdminController
  before_action :set_record, only: [:update, :destroy]
  before_action :set_cour

  # GET /admin/records
  def index
    @records =
      Record.cour(@cour)
            .includes(:user)
            .order(started_at: :asc, user_id: :asc)
  end

  # POST /admin/records.js
  def create
    @record = Record.new(record_params)
    @record.started_at ||= Time.current
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

  def record_params
    params.require(:record)
          .permit(:user_id, :started_at, :finished_at, :started_on, :dateless_started_at, :dateless_finished_at)
  end
end
