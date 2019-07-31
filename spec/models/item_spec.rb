# frozen_string_literal: true

RSpec.describe Item, type: :model do
  describe 'fields' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:text) }
    it { is_expected.to have_db_column(:image_url).of_type(:string) }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
