# frozen_string_literal: true

class User::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json
end