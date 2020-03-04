class MedalistFormatter
  def initialize(event, medalists)
    @event = event
    @medalists = medalists
  end

  def json_response
    medalist_info = medalists.map do |medalist|
      {
        'name' => medalist.name,
        'team' => medalist.team.country,
        'age' => medalist.age,
        'medal' => medalist.olympian_events.where(event_id: event.id)[0].medal.capitalize
      }
    end

    {
      'event' => event.name,
      'medalists' => medalist_info
    }
  end

  private

  attr_reader :event, :medalists
end
