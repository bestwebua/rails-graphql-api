# frozen_string_literal: true

RSpec::Matchers.define :match_schema do |schema|
  match do |response|
    @result = schema.call(JSON.parse(response.body))
    @result.success?
  end

  def failure_message
    @result.errors.to_h
  end
end
