class Team < ApplicationRecord
  belongs_to :pool
  has_many :team_players
  has_many :players, through: :team_players
  has_many :scores

  has_many :match_teams
  has_many :matchs, through: :match_teams 
end
