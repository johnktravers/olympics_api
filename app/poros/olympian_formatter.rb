class OlympianFormatter
  def initialize(serialized_olympians)
    @data = JSON.parse(serialized_olympians)['data']
  end

  def json_response
    olympians = data.map { |olympian_data| olympian_data['attributes'] }
    { 'olympians' => olympians }
  end

  private

  attr_reader :data
end
