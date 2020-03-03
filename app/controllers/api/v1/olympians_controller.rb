class Api::V1::OlympiansController < ApplicationController
  def index
    if params[:age]
      if params[:age] == 'youngest'
        olympians = Olympian.youngest_olympians.includes(:team, :sport, :olympian_events)
      elsif params[:age] == 'oldest'
        olympians = Olympian.oldest_olympians.includes(:team, :sport, :olympian_events)
      else
        error = "Invalid request. Please enter either 'youngest' or 'oldest' for the age parameter."
        return render json: Error.new(error).json, status: 400
      end
    else
      olympians = Olympian.includes(:team, :sport, :olympian_events)
    end

    serialized_olympians = OlympianSerializer.new(olympians).serialized_json
    formatted_olympians = OlympianFormatter.new(serialized_olympians).json_response
    render json: formatted_olympians
  end
end
