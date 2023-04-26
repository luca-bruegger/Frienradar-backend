# frozen_string_literal: true

class User < ApplicationRecord
  GEOHASH_LENGTHS = [6, 5, 3, 2].freeze

  before_create :assign_guid
  before_create :check_profile_picture_size
  after_create :build_geolocation

  has_one_attached :profile_picture
  has_one :geolocation, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }, allow_blank: true
  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :profile_picture, presence: true
  validates :preferred_distance, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }

  has_many :invitations, dependent: :destroy
  has_many :pending_invitations, -> { where(confirmed: false) }, class_name: 'Invitation', foreign_key: 'user_id', dependent: :destroy

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :validatable,
         :jwt_authenticatable,
         :confirmable,
         :lockable,
         jwt_revocation_strategy: JwtDenylist


  def invite(friend_id)
    return if friend_id == id

    invitation = invitations.find_by(friend_id: friend_id)
    return invitation if invitation.present?

    return if Invitation.confirmed_record?(user_id: id, friend_id: friend_id)

    invitations.new(friend_id: friend_id)
  end

  def friends
    friends_i_sent_invitations = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitations = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    return [] if friends_i_sent_invitations.empty? && friends_i_got_invitations.empty?

    combined_friends = friends_i_sent_invitations + friends_i_got_invitations
    User.where(id: combined_friends)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(user_id: id, friend_id: user.id) || Invitation.confirmed_record?(user_id: user.id, friend_id: id)
  end

  def received_invitations
    Invitation.where(friend_id: id, confirmed: false)
  end

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

  def build_geolocation
    Geolocation.create!(user: self, geohash: nil)
  end
end
