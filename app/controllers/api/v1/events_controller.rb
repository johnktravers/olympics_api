class Api::V1::EventsController < ApplicationController
  def index
    sports = Sport.includes(:events).order(:name)
    formatted_events = EventFormatter.new(sports).json_response
    render json: formatted_events
  end
end
