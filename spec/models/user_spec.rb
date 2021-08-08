require "rails_helper"

RSpec.describe User, type: :model do
  before { create(:user) }

  it { is_expected.to validate_uniqueness_of(:email) }
end
