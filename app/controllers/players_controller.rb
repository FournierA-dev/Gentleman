class PlayersController < ApplicationController

  before_action :authenticate_player!

  def index
    @players=Player.all
  end

  def show
    @player=current_player
  end

  def edit
  end

  def update
  end

end
