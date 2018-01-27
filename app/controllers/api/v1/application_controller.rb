class Api::V1::ApplicationController < ApplicationController
  # accessing through api does not require authenticity token
  skip_before_action :verify_authenticity_token

  before_action :set_default_format
  before_action :authenticate_token!

  private

    def set_default_format
      request.format = :json
    end

    def authenticate_token!
      payload = JsonWebToken.decode(auth_token)
      @current_user = User.find(payload["sub"])
    rescue JWT::ExpiredSignature
      render json: {error: ["Auth token has expired"]}, status: :unauthorized
    rescue JWT::DecodeError
      render json: {error: ["Invalid auth token"]}, status: :unauthorized
    end

    def auth_token
      # headers contains http headers, a hash like object in which key Authorization has jwt token
      @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
    end

end
