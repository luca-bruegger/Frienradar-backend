class Invitation < ApplicationRecord
  belongs_to :user


  def accept
    update_attribute(:confirmed, true)
  end

  def friend
    User.find(friend_id)
  end

  def self.reacted?(user_id, friend_id)
    self_case = Invitation.where(user_id: user_id, friend_id: friend_id).exists?
    friend_case = Invitation.where(user_id: friend_id, friend_id: user_id).exists?
    self_case || friend_case
  end

  def self.confirmed_record?(user_id:, friend_id:)
    self_case = Invitation.where(user_id: user_id, friend_id: friend_id, confirmed: true).exists?
    friend_case = Invitation.where(user_id: friend_id, friend_id: user_id, confirmed: true).exists?
    self_case || friend_case
  end

  def self.find_invitation(user_id, friend_id)
    if Invitation.where(user_id: user_id, friend_id: friend_id, confirmed: true).exists?
      Invitation.where(user_id: friend_id, friend_id: user_id, confirmed: true).first
    else
      Invitation.where(user_id: user_id, friend_id: friend_id, confirmed: true).first
    end
  end
end
