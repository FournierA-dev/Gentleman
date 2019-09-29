module PermissionHelper

def isAdmin?
  player_signed_in? && $admin_mails.include?(current_player.email)
end


end
