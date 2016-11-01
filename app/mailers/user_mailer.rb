class UserMailer < ApplicationMailer
  def forgot_password(user)
    @user = user

    mail(to: user.email, subject: "Recover Password")
  end 

  def invite_user(user, opts)
  
  	@role = opts[:role]
  	@org = opts[:org]
  	@user = user
  	mail(to: @user.email, subject: "CodePaying - Added to the Organization #{@org}")
  end

  def identity_update(user)
    @user = user 
    mail(:to => 'gulsharn.codegarage@gmail.com', :subject => " user has updated Identification Document", :body => "Please Verify The identity proof for == #{@user} ==")
  end

end
