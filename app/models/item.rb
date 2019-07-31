# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
end
