class ApplicationMailer < ActionMailer::Base
  default from: "notification@codepayer.com"
  layout 'mailer'
end
