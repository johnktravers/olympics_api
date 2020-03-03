class OlympianSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :team, :age, :sport, :total_medals_won

  attribute :team  { |olympian| olympian.team.country }
  attribute :sport { |olympian| olympian.sport.name }
end
