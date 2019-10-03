module Admin
  class PoolsController < ApplicationController
    
    before_action :authenticate_player!
    before_action :set_pools, only: [:index, :edit]

    def index
      @pool = Pool.new
      @pools = Pool.all
    end

    def create
      pools_nb = Pool.all.count
      if pool_max_test?(pools_nb)
        pool = Pool.new(name: (65+pools_nb).chr)
        # 65.chr = "A"            "A".ord = 65
        if pool.save
          redirect_to admin_pools_path ,success: "Poule #{pool.name} créée avec succès"
        else
          render request.referer, danger: "Erreur dans la création de la nouvelle poule"
        end
      end
    end

    def destroy
      @pool = Pool.find(params[:id])
      if @pool.teams.count > 0
        redirect_to admin_pools_path, warning: "Vous ne pouvez pas supprimer une poule dans laquelle une équipe est affectée"
      else
        @pool.destroy
        rename_other_pools_after_delete
        redirect_to request.referer, success: "Poule supprimée avec succès"
      end
    end

    private


    def set_pools
      @pools_select=[]
      Pool.all.each do |pool|
        @pools_select << [pool.name,pool.id]
      end
    end

    def rename_other_pools_after_delete
      i=0
      Pool.all.each do |pool|
        pool.update(:name => (65+i).chr )
        i+=1
      end
    end

    def pool_max_test?(pools_nb)
      if pools_nb == 20
        render request.referer, warning: "Maximum de 20 poules atteind."
        return false
      else
        return true
      end
    end

  end
end