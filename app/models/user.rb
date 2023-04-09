# frozen_string_literal: true

class User < ApplicationRecord
  before_create :assign_guid
  before_create :check_profile_picture_size

  has_one_attached :profile_picture
  has_one :geolocation, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }, allow_blank: true
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :profile_picture, presence: true
  validates :preffered_distance, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :jwt_authenticatable,
         :confirmable,
         :lockable,
         jwt_revocation_strategy: JwtDenylist

  private

  def assign_guid(attempts = 10)
    retries ||= 0
    self.guid = SecureRandom.urlsafe_base64(nil, false)
  rescue ActiveRecord::RecordNotUnique => e
    raise if (retries += 1) > attempts

    Rails.logger.warn("random token, unlikely collision number #{retries}")
    self.guid = SecureRandom.urlsafe_base64(16, false)
    retry
  end

  def check_profile_picture_size
    return unless profile_picture.attached?

    return unless profile_picture.blob.byte_size > 5.kilobyte

    errors.add(:profile_picture, 'must be less than 5KB')
  end
end
