class Api::V1::ApplicationController < ApplicationController
  # accessing through api does not require authenticity token
  skip_before_action :verify_authenticity_token

  before_action :set_default_format
  before_action :authenticate_user!

  private

    def set_default_format
      request.format = :json
    end

end
