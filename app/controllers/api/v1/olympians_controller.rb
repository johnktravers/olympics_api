class Api::V1::OlympiansController < ApplicationController
  def index
    olympians = Olympian.includes(:team, :sport, :olympian_events)
    serialized_olympians = OlympianSerializer.new(olympians).serialized_json
    formatted_olympians = OlympianFormatter.new(serialized_olympians).json_response
    render json: formatted_olympians
  end
end
