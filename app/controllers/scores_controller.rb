class ScoresController < ApplicationController

  before_action :authenticate_player!  

  def new
    @match = Match.find(params[:match_id])
    @team_score = Score.new(match_id: @match.id, team_id: current_player.team.id)
    @team_score.score = []
    @team_score.opponent_score = []
  end

  def create
    @match = Match.find(params[:match_id])
    puts "@"*100
    puts params
    if test_results?(score_params[:score],score_params[:opponent_score])
      @match = Match.find(params[:match_id])
      @team_score = Score.new(match_id: @match.id, team_id: current_player.team.id, score: score_params[:score])
      @opponent_score = Score.new(match_id: @match.id,team_id: @match.teams.where.not(id: current_player.team.id)[0].id,score: score_params[:opponent_score])

      if @team_score.save && @opponent_score.save
        puts "@"*100
        puts @team_score.inspect

        update_match_point
        redirect_to matchs_path, success: "Résultat du match bien enregistré."
      else
        render request.referer, danger:"Attention : scores non enregistrés !"
      end
    end
  end

  def edit
    @match = Match.find(params[:match_id])
    @team_score = @match.scores.where(team_id: current_player.team.id)[0]
    @team_score.opponent_score = @match.scores.where.not(team_id: current_player.team.id)[0].score
  end

  def update
    puts "@"*100
    puts params
    @match = Match.find(params[:match_id])
    @team_score = Score.find_by(match_id: @match.id, team_id: current_player.team.id)
    @opponent_score = Score.find_by(match_id: @match.id,team_id: @match.teams.where.not(id: current_player.team.id)[0].id)

    if test_results?(score_params[:score],score_params[:opponent_score])
      if @team_score.update(score: score_params[:score]) && @opponent_score.update(score: score_params[:opponent_score])
        update_match_point
        redirect_to matchs_path, success: "Résultat du match bien modifié."
      else
        render request.referer, danger:"Attention : scores non modifiés !"
      end
    end
  end

  private

  def score_params
    params.permit(:score => [], :opponent_score => [])
  end

  def update_match_point
    if global_match_status
      @team_score.match_point = 2
      @opponent_score.match_point = 1
    else
      @team_score.match_point = 1
      @opponent_score.match_point = 2
    end
    @team_score.save
    @opponent_score.save
  end

  def global_match_status
    nb_victory = 0
    nb_null = 0
    @team_score.score.count.times do |i|
      if @team_score.score[i] > @opponent_score.score[i]
        nb_victory += 1
      elsif @team_score.score[i] == @opponent_score.score[i]
        nb_null += 1
      end
    end
    if nb_victory > (@team_score.score.count - nb_null- nb_victory)
      return true
    else
      return false
    end
  end

  def test_results?(score,opponent_score)
    score.size.times do |i|
      if score[i].blank? || opponent_score[i].blank?
        redirect_to new_match_score_path(@match), danger:"Aucun score ne doit être renseigné vide. Si l'un des matchs n'a pas été joué mettre 0 pour les deux scores"
        return false
      end
    end
    score.size.times do |i|
      score_conv = score[i].to_i unless score[i].match(/[^[:digit:]]+/)
      opponent_score_conv = opponent_score[i].to_i unless opponent_score[i].match(/[^[:digit:]]+/)
      if !score_conv.is_a?(Integer) || !opponent_score_conv.is_a?(Integer)
        redirect_to new_match_score_path(@match), danger:"Les scores rentrés doivent être des entiers ! "
        return false
      end
    end

  end

end
