class PlayersController < ApplicationController

  before_action :authenticate_player!

  def index
    @players=Player.all.order(last_name: :asc)
  end

  def show
    @player=current_player
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    if @player= Player.update(player_params)
      redirect_to admin_players_path, success: "Joueur modifié avec succès. Un mail de confirmation a été transmis !"
    else
      render :edit
    end
  end

  private

  def player_params
    params.require(:player).permit(:first_name,:last_name, :role, :tel_number,:email)
  end

end
