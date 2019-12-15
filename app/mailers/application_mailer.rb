class ApplicationMailer < ActionMailer::Base
  default to: 'foo@bar.com', from: 'foo@bar.com'
  layout 'mailer'

end
