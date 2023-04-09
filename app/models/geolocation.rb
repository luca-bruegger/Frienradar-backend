# frozen_string_literal: true

class Geolocation < ApplicationRecord
  belongs_to :user

  validates :guid, presence: true
  validates :user, presence: true
end
