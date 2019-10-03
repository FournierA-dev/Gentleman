class MatchsController < ApplicationController

  before_action :authenticate_player!

  def index #Liste de tous les prochains matchs programmés
    @matchs = current_player.team.matchs
  end

  def edit
    
  end

end
