module PoolsHelper

  def pool_match_count(pool)
    i=1
    teams_count = pool.teams.count
    match_count = 0

    if teams_count == 0 || teams_count == 1
      return match_count
    end
    (teams_count-1).times do
      match_count += i
      i+=1
    end
    return match_count
  end

  def pool_match_done(pool)
    match_done = 0
    pool.teams.each do |team|
      team.matchs.each do |match|
        match_done += match.scores.count / 2
      end
    end
    return match_done
  end



end
