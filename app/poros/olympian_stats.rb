class OlympianStats
  def initialize(olympians)
    @olympians = olympians
  end

  def json_response
    {
      'olympian_stats' => {
        'total_competing_olympians' => olympians.total_competing_olympians,
        'average_weight' => {
          'unit' => 'kg',
          'male_olympians' => olympians.average_weight_by_sex('M').to_f.round(1),
          'female_olympians' => olympians.average_weight_by_sex('F').to_f.round(1)
        },
        'average_age' => olympians.average_age.to_f.round(1)
      }
    }
  end

  private

  attr_reader :olympians
end
