# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |_e|
    render json: { error: "Record not found" }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid do |_e|
    render json: { error: "Record Invalid" }, status: :unprocessable_entity
  end
end
