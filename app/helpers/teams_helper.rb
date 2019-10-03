module TeamsHelper


  def team_match_done(team)
    match_done = 0
      team.matchs.each do |match|
        match_done += match.scores.count
      end
    return match_done
  end


end
