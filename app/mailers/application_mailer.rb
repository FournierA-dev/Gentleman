class ApplicationMailer < ActionMailer::Base
  default from: 'no_reply@gentleman-dev.herokuapp.com'
  layout 'mailer'

  add_template_helper(MailHelper)

end
