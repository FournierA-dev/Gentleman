module Admin

  class ApplicationController < ::ApplicationController

    before_action :only_admin
    add_flash_types :info, :success, :warning, :danger
    layout 'application'

    private

    def only_admin
      if !player_signed_in? && !$admin_mails.include?(current_player.email)
        redirect_to root_path, danger: "Vous n'avez pas les droits d'administration du site..."
      end
    end

  end

end
