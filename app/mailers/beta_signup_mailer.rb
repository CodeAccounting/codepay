class BetaSignupMailer < ApplicationMailer
  def welcome(signup)
    mail(to: signup.email, subject: 'Welcome to Codepaying!')
  end
end
