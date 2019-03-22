require "rails_helper"

RSpec.describe UserSetting, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:currency).scoped_to([:user_id]) }
end
