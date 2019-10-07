class Player < ApplicationRecord
  before_create :default_values_if_nil
  before_update :default_values_if_nil

  after_create :welcome_send

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :team_player
  has_one :team, through: :team_player


private 

  def default_values_if_nil
    if !self.first_name
      self.first_name =""
    end
    if !self.last_name
      self.last_name = ""
    end
  end

  def welcome_send
    PlayerMailer.welcome_email(self).deliver_now
  end

end
