class EventFormatter
  def initialize(sports)
    @sports = sports
  end

  def json_response
    events = sports.map do |sport|
      {
        'sport' => sport.name,
        'events' => sport.events.order(:name).pluck(:name)
      }
    end

    { 'events' => events }
  end

  private

  attr_reader :sports
end
