class Team < ApplicationRecord

after_create :team_match_refresh
before_destroy :all_match_destroy

  belongs_to :pool
  has_many :team_players, dependent: :destroy
  has_many :players, through: :team_players
  has_many :scores, dependent: :destroy

  has_many :match_teams
  has_many :matchs, through: :match_teams, dependent: :destroy

  private

  def team_match_refresh
    if self.matchs.blank? || self.matchs.count != 0 
      self.pool.teams.each do |team|
        if team != self
          match = Match.new()
          match.team_ids = [self.id,team.id]
          match.save
        end
      end
    end
  end

  def all_match_destroy
    self.matchs.each do |match|
      match.destroy
    end
  end

end
