class Error
  def initialize(message)
    @message = message
  end

  def json
    { 'error' => message, 'status' => '400 Bad Request' }
  end

  private

  attr_reader :message
end
