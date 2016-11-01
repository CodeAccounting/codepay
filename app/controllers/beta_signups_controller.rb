class BetaSignupsController < ApplicationController
  def create
    @signup = BetaSignup.new(signup_params)

    if @signup.save
      BetaSignupMailer.welcome(@signup).deliver_later
      redirect_to @signup
    else
      redirect_to "/"
    end
  end

  def show
  end

  private

  def signup_params
    params.require(:signup).permit(:email)
  end
end
