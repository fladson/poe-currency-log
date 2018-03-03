require "rails_helper"

RSpec.describe CurrencyLog, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_uniqueness_of(:data).scoped_to([:user_id, :league]) }
end
