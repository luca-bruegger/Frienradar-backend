# frozen_string_literal: true

class User < ApplicationRecord
  before_create :assign_guid
  has_one_attached :profile_picture

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         :confirmable,
         :trackable,
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
end
