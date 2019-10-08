class PlayersController < ApplicationController

  before_action :authenticate_player!

  def index
    @players=Player.all.order(first_name: :desc).order(email: :asc)
  end

  def show
    @player=current_player
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      redirect_to player_path(current_player), success: "Informations modifiées avec succès !"
    else
      render :edit
    end
  end

  private

  def player_params
    params.require(:player).permit(:first_name,:last_name, :role, :tel_number, :linkedin, :viadeo)
  end

end
