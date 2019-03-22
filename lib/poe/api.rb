# frozen_string_literal: true

module POE
  class API
    BASE    = 'https://www.pathofexile.com/'
    ACCOUNT = '/my-account'
    CHARS   = '/character-window/get-characters'
    STASH   = '/character-window/get-stash-items'

    def initialize(session)
      @session = session
    end

    def client
      connection ||= Faraday.new(url: BASE) do |faraday|
        faraday.use ErrorHandling
        faraday.adapter Faraday.default_adapter
        faraday.headers = {
          'Content-Type' => 'application/json',
          'Cookie' => "POESESSID=#{session}"
        }
      end
    end

    def account_name
      response = client.get(ACCOUNT)
      match = %r{/account/view-profile/(.*?)\"}.match(response.body)

      match[1]
    end

    def chars
      response = client.get(CHARS)

      JSON.parse(response.body)
    end

    def stash_tabs(account_name, league)
      tabs = []
      tabs_count = number_of_tabs(account_name, league)
      return unless tabs_count

      tabs_count.times do |tab_index|
        tabs << client.get(tabs_path(account_name, league, tab_index)).body.freeze
      end

      tabs
    end

    def number_of_tabs(account_name, league)
      path = tabs_path(account_name, league)
      response = client.get(path)

      JSON.parse(response.body)['numTabs']
    end

    private

    attr_reader :session

    def tabs_path(account_name, league, tab_index = 0)
      STASH + "?accountName=#{account_name}&league=#{league}&tabs=0&tabIndex=#{tab_index}"
    end
  end
end
