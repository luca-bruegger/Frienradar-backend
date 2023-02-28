# frozen_string_literal: true

class User < ApplicationRecord
  before_create :assign_guid
  before_create :check_profile_picture_size

  has_one_attached :profile_picture

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
  validates :profile_picture, presence: true

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
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
