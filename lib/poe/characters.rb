class Poe::Characters
  BASE = "/character-window/get-characters".freeze
  class << self
    def get_json(api)
      response = api.get(BASE)
      raise Faraday::ConnectionFailed.new(response) unless response.status == 200

      JSON.parse(response.body)
    end
  end
end
