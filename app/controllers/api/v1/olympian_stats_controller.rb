class Api::V1::OlympianStatsController < ApplicationController
  def show
    olympians = Olympian.all
    stats = OlympianStats.new(olympians).json_response
    render json: stats
  end
end
