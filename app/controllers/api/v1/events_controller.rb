class Api::V1::EventsController < ApplicationController
  def index
    sports = Sport.includes(:events).order(:name)
    formatted_events = EventFormatter.new(sports).json_response
    render json: formatted_events
  end

  def show
    event = Event.find_by(id: params[:id])
    if event
      medalists = Olympian
        .includes(:team)
        .joins(:olympian_events)
        .where('olympian_events.medal > 0 AND olympian_events.event_id = ?', event.id)
        .order('olympian_events.medal DESC, olympians.id')

      formatted_medalists = MedalistFormatter.new(event, medalists).json_response
      render json: formatted_medalists
    else
      error = 'Invalid event ID. Please try again with an integer between 1 and 305.'
      return render json: Error.new(error).json, status: 400
    end
  end
end
