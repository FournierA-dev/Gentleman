class MatchsController < ApplicationController

  before_action :authenticate_player!

  def index #Liste de tous les prochains matchs programmés
    @team = @matchs = current_player.team
    if @team
      @matchs = current_player.team.matchs
    else
      @matchs
    end
  end

  def edit
    
  end

end
