class Match < ApplicationRecord
  has_many :match_teams
  has_many :teams, through: :match_teams 
  has_many :scores
end
