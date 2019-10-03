class TeamPlayer < ApplicationRecord
  validates :player_id,uniqueness: true
  
  belongs_to :team
  belongs_to :player
end
