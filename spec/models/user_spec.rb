# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_many(:items).dependent(:destroy) }
  end
end
