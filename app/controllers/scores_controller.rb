class ScoresController < ApplicationController

  def new
    @match = Match.find(params[:match_id])
    @team_score = Score.new(match_id: @match.id, team_id: current_player.team.id)
  end

  def create
    @match = Match.find(params[:match_id])
    @team_score = Score.new(match_id: @match.id, team_id: current_player.team.id, score: score_params[:score])
    @opponent_score = Score.new(match_id: @match.id,team_id: @match.teams.where.not(id: current_player.team.id)[0].id,score: score_params[:opponent_score])

    if @team_score.save && @opponent_score.save
      update_match_score
      redirect_to matchs_path, success: "Résultat du match bien enregistré. Un mail récapitulatif a été envoyé à l'équipe adverse"
    else
      render request.referer, danger:"Attention : scores non enregistrés !"
    end
  end

  def edit
    @match = Match.find(params[:match_id])
    @team_score = @match.scores.where(team_id: current_player.team.id)[0]
    @team_score.opponent_score = @match.scores.where.not(team_id: current_player.team.id)[0].score
  end

  def update
    @match = Match.find(params[:match_id])
    @team_score = Score.find_by(match_id: @match.id, team_id: current_player.team.id)
    @opponent_score = Score.find_by(match_id: @match.id,team_id: @match.teams.where.not(id: current_player.team.id)[0].id)

    if @team_score.update(score: score_params[:score]) && @opponent_score.update(score: score_params[:opponent_score])
      update_match_score
      redirect_to matchs_path, success: "Résultat du match bien modifié. Un mail récapitulatif a été envoyé à l'équipe adverse"
    else
      render request.referer, danger:"Attention : scores non modifiés !"
    end
  end

  private

  def score_params
    params.require(:score).permit(:score,:opponent_score)
  end

  def update_match_score
    if @team_score.score.to_i > @opponent_score.score.to_i
      if @team_score.score.to_i-@opponent_score.score.to_i >10
        @team_score.match_point = 3
      else
        @team_score.match_point = 2
      end
      @opponent_score.match_point = 1
    else
      if @opponent_score.score.to_i-@team_score.score.to_i >10
        @opponent_score.match_point = 3
      else
        @opponent_score.match_point = 2
      end
      @team_score.match_point = 1
    end
    @team_score.save
    @opponent_score.save
  end


end
