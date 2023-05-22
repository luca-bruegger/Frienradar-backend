# frozen_string_literal: true

class Geolocation < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
end
