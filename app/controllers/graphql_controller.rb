# frozen_string_literal: true

class GraphqlController < ApplicationController
  def execute
    result = RailsGraphqlApiSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: { current_user: current_user },
      operation_name: params[:operationName]
    )

    render json: result
  rescue StandardError => error
    raise error unless Rails.env.development?

    handle_error_in_development(error)
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def handle_error_in_development(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))

    render json: {
      error: {
        message: error.message,
        backtrace: error.backtrace
      },
      data: {}
    }, status: 500
  end
end
