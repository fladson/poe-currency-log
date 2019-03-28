# frozen_string_literal: true

module UserDataService
  def self.create(user_email)
    user = User.find_by_email(user_email)
    api = POE::API.new(user.session)

    user.update(account_name: api.account_name, chars: api.chars)
    # this needs to be done after the chars update
    temp_leagues = user.temp_leagues | user.current_temp_leagues
    user.update(temp_leagues: temp_leagues)
  end
end
