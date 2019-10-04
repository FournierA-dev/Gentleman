module TeamsHelper


  def team_match_done(team)
    match_done = 0
      team.matchs.each do |match|
        match_done += match.scores.where(team_id: team.id).count
      end
    return match_done
  end


end
