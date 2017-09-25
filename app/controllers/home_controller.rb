class HomeController < ApplicationController
  def index
    @users = User.order(id: :asc)
    @records = Record.recent.group_by(&:user_id)
  end
end
