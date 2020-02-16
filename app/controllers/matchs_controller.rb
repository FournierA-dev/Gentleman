class MatchsController < ApplicationController

  before_action :authenticate_player!

  def index #Liste de tous les prochains matchs programmés
    @team = current_player.team
    if @team
      @matchs = @team.matchs
    else
      @matchs
    end
  end

  def update
    @match = Match.find(params[:id])
    if @match.update(match_params)
      redirect_to matchs_path, success: "Date créée/modifiée avec succès !"
    else
      render matchs_path, danger: "Erreur dans la modification / création de la date de jeu"
    end
  end


  def match_params
    params.require(:match).permit(:date)
  end

end
