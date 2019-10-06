module ScoresHelper

  def team_match_scores(match,team)
    match_score = match.scores.where(team_id:  team.id)[0]
    if match_score
      return match_score.score
    else
      return []
    end
  end

  def global_match_status(team_array,opponent_array)
    if !team_array || team_array.count == 0
      return "text-secondary","..."
    end
    nb_victory = 0
    team_array.count.times do |i|
      if team_array[i] > opponent_array[i]
        nb_victory += 1
      end
    end
    if nb_victory > (team_array.count - nb_victory)
      return "text-success","Gagné"
    else
      return "text-danger","Perdu"
    end
  end


end
