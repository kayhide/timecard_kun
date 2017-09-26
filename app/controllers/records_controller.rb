class RecordsController < ApplicationController
  before_action :set_user

  # POST /user/1/records/start
  def start
    @record = @user.records.create(started_at: Time.current)
    render :update
  end

  # POST /user/1/records/finish
  def finish
    @record = @user.records.unfinished.recent.last || @user.records.create
    @record.finished_at = Time.current
    @record.save
    render :update
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
