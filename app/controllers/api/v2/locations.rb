require "sinatra"

module Api
  module V2
    class Locations < Sinatra::Base
      before do
        headers "Content-Type" => "application/json"
      end

      get "/:id" do # only after entering into get params[:id] is available
        location = Location.find(params[:id])
        LocationSerializer.new(location).to_json
      end
    end
  end
end
