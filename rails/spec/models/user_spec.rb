require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :user }

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end 
end
