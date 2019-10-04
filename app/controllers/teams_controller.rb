class TeamsController < ApplicationController


  def index
    @teams = Team.all.order("total_score desc")
  end

  def show
    @team = Team.find(params[:id])
  end

  private

end
