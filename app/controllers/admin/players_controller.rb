module Admin
  class PlayersController < ApplicationController

    before_action :authenticate_player!

    def index
      @players=Player.all
    end

    def new
      @player=Player.new
    end

    def create
      @player = Player.new(player_params)
      @player.password = rand(111111..999999)
      if @player.save
        redirect_to admin_players_path, success: "Joueur ajouté avec succès. Un mail d'invitation a été transmis !"
      else
        render :new
      end
    end

    def edit
      @player = Player.find(params[:id])
    end

    def update
      @player = Player.find(params[:id])      
      if @player.update(player_params)
        redirect_to admin_players_path, success: "Joueur modifié avec succès. Un mail de confirmation a été transmis !"
      else
        render :edit
      end
    end

    def destroy
      Player.find(params[:id]).destroy
      redirect_to request.referrer, success: "Joueur supprimé avec succès"
    end

    private

    def player_params
      params.require(:player).permit(:first_name,:last_name, :role, :tel_number,:email)
    end

  end
end