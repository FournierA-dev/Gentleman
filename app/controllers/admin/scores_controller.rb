module Admin
  class ScoresController < ApplicationController
    
    before_action :authenticate_player!

    def index
      @scores = Score.all
    end

    def destroy
      @score = Score.find(params[:id])
        @score.destroy
        redirect_to request.referer, success: "Score supprimé avec succès"
    end

    def edit

    end

    def update

    end
    
    private



  end
end