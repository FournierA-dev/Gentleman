class Score < ApplicationRecord

  attr_accessor :opponent_score 

  after_create :update_total_score
  after_update :update_total_score

  belongs_to :match
  belongs_to :team

  private

  def update_total_score
    self.team.total_score = 0
    Score.where(team_id: self.team.id).each do |score|
      if score.match_point
        team.total_score += score.match_point.to_i
      end
    end
    self.team.save
  end

end
