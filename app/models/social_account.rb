class SocialAccount < ApplicationRecord
  belongs_to :user

  enum provider: {
    discord: 0,
    twitter: 1,
    instagram: 2,
    snapchat: 3,
    facebook: 4,
    linkedin: 5,
    tiktok: 6,
    youtube: 7,
    twitch: 8,
    reddit: 9,
    github: 10,
    pinterest: 11,
    tumblr: 12,
    soundcloud: 13,
    spotify: 14,
    steam: 15,
    xbox: 16,
    playstation: 17,
    nintendo: 18,
    deezermusic: 19,
  }

  validates :provider, presence: true
  validates :username, presence: true
  validates :username, length: { minimum: 3, maximum: 30 }
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: :provider }
  validates :provider, inclusion: { in: SocialAccount.providers.keys }
end
