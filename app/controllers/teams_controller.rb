class TeamsController < ApplicationController

  before_action :authenticate_player!

  def index
    @teams = Team.order(total_score: :desc)
  end

  def show
    @team = Team.find(params[:id])
  end

end
