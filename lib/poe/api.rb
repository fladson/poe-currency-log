module POE
  class API
    BASE = "https://www.pathofexile.com/".freeze
    ACCOUNT = "/my-account".freeze
    CHARS = "/character-window/get-characters".freeze
    STASH = "/character-window/get-stash-items".freeze

    attr_reader :session

    def initialize(session)
      @session = session
    end

    def account_name
      response = client.get(ACCOUNT)
      match = /\/account\/view-profile\/(.*?)\"/.match(response.body)
      raise POE::Error::InvalidSession, "Session invalid: Couldn't retrieve the account name" unless match

      match[1]
    end

    def chars
      response = client.get(CHARS)

      JSON.parse(response.body)
    end

    def stash_tabs(account_name, league)
      tabs = []
      number_of_tabs(account_name, league).times do |tab_index|
        tabs << client.get(tabs_path(account_name, league, tab_index)).body.freeze
      end

      tabs
    end

    def number_of_tabs(account_name, league)
      path = tabs_path(account_name, league)
      response = client.get(path)

      JSON.parse(response.body)["numTabs"]
    end

    def client
      connection ||= Faraday.new(url: BASE) do |faraday|
        faraday.use ErrorHandling
        faraday.adapter Faraday.default_adapter
        faraday.headers = {
          "Content-Type" => "application/json",
          "Cookie" => "POESESSID=#{session}"
        }
      end
    end

    private

    def tabs_path(account_name, league, tab_index = 0)
      STASH + "?accountName=#{account_name}&league=#{league}&tabs=0&tabIndex=#{tab_index}"
    end
  end
end
