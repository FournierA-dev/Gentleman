module Admin
  class TeamsController < ApplicationController
    
    before_action :authenticate_player!
    before_action :set_players, only: [:index, :edit]
    before_action :set_pools, only: [:index, :edit]

    def index
      if Pool.all.count == 0
        redirect_to admin_pools_path ,danger: "Aucune équipe ne peut être créée sans poule"
      end
      @team = Team.new
      @teams = Team.all
    end

    def create
      if !params.require(:team)[:player_ids].blank?
        selected_teams_nb = params.require(:team)[:player_ids].count
      else
        selected_teams_nb = 0
      end
      if team_number_test?(selected_teams_nb)
        @team = Team.new(params.require(:team).permit(:pool_id, player_ids: []))
        @team.name = "NoName"
        if @team.save
          #Création des matchs non actuellement programmés avec les autres equipes de la poule
          redirect_to admin_teams_path ,success: "Equipe créée avec succès"
        else
          redirect_to admin_teams_path, danger: "Erreur dans la création de la nouvelle équipe; Vous avez probablement sélectionné un joueur déjà affécté à une autre équipe"
        end
      end
    end

    def edit
      @team = Team.find(params[:id])
    end

    def update
      @team = Team.find(params[:id])
      if test_no_team_scores_if_pool_change?(params[:team]['pool_id'])
        if @team.update(team_params)
          redirect_to request.referer, success: "Equipe modifiée avec succès. Un mail de confirmation a été transmis !"
        else
          render request.referer, danger: "Mise à jour impossible de l'équipe"
        end
      end
    end

    def destroy
      Team.find(params[:id]).destroy
      redirect_to request.referer, success: "Equipe supprimée avec succès"
    end
    
private 

    def set_players
      @players=[]
      Player.all.each do |player|
        @players << [player.first_name + player.last_name ,player.id]
      end
    end

    def set_pools
      @pools_select=[]
      Pool.all.each do |pool|
        @pools_select << [pool.name,pool.id]
      end
    end

    def team_params
      params.require(:team).permit(:name,:pool_id)
    end

    def team_number_test?(selected_teams_nb)
      if selected_teams_nb != 2
        redirect_to admin_teams_path ,warning: "Une équipe doit être constituée de 2 joueurs"
        return false
      else
        return true
      end
    end

    def test_no_team_scores_if_pool_change?(pool_id)
      if @team.pool != Pool.find(pool_id)
        @team.matchs.each do |match|
          if match.scores.count > 0
            redirect_to admin_pools_path, danger: "Impossible de changer de poule car l'équipe a déjà fait des matchs"
            return false
          end
        end
      end
      return true
    end

  end
end