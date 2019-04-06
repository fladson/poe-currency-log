# frozen_string_literal: true

module UpdateAccountDataService
  def self.call(user)
    api = POE::API.new(user.session)

    user.update(account_name: api.account_name, chars: api.chars)
  end
end
