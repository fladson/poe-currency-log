class Poe::Connection
  BASE = "https://www.pathofexile.com/".freeze

  def self.api(session)
    Faraday.new(url: BASE) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers = {
        "Content-Type" => "application/json",
        "Cookie" => "POESESSID=#{session}"
      }
    end
  end
end
