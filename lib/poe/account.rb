class Poe::Account
  BASE = "/my-account".freeze

  def self.get_account_name(api)
    response = api.get(BASE)
    match = /\/account\/view-profile\/(.*?)\"/.match(response.body)

    match[1]
  end
end
