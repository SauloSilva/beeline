class ApplicationController < ActionController::API
  include ActionController::Serialization

  protected

  def format_errors(record)
    { errors: record.errors }
  end
end
