class PlayerMailer < ApplicationMailer

  def welcome_email(player)

    @player = player 
    @mdp = $mdp_temp
    @url  = 'https://gentleman-dev.herokuapp.com' 

    mail(to: @player.email, subject: 'Gentlemen : plateforme de suivi de tournoi !') 
  end

end
