# frozen_string_literal: true

class ApplicationController < ActionController::API

  def not_found
    render plain: "Not found.", status: 404
  end
end
