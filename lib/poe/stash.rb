class Stash
  BASE = "https://www.pathofexile.com/character-window/get-stash-items".freeze
  class << self
    def tabs(api, account_name, league)
      path = BASE + "?accountName=#{account_name}&league=#{league}"
      tabs = []
      num_tabs(api, account_name, league).times do |tab_index|
        tabs << api.get(path + "&tabs=0&tabIndex=#{tab_index}").body
      end

      tabs
    end

    def num_tabs(api, account_name, league)
      path = BASE + "?accountName=#{account_name}&league=#{league}&tabs=0&tabIndex=0"
      response = api.get(path)
      raise Faraday::ConnectionFailed.new response unless response.status == 200

      JSON.parse(response.body)["numTabs"]
    end
  end
end
