class HomeController < ApplicationController
  def index
    @users = User.without_hidden.order(id: :asc)
    @records = Record.recent.order(started_at: :desc).group_by(&:user_id)
  end
end
