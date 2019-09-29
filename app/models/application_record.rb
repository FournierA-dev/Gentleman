class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  $admin_mails = ["yop.fou@laposte.net","ahm.fournier@laposte.net","bertrand.darracq@xerox.com"]
end
