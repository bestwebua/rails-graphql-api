# frozen_string_literal: true

module Helpers
  def create_access_token(email)
    Base64.encode64(email)
  end
end
