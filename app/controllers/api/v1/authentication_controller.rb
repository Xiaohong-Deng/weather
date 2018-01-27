class Api::V1::AuthenticationController < Api::V1::ApplicationController
  skip_before_action :authenticate_user!

  def create
    user = User.find_by(email: params[:user][:email])
    # devise provides valid_password?
    if user.valid_password? params[:user][:password]
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { error: ["Invalid email or password"] }
    end
  end
end
