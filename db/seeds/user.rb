# frozen_string_literal: true

class UserSeeds
  def self.generate
    3.times do |index|
      new.generate(index)
    end
  end

  def generate(index)
    User.create!(
      name: ::Faker::Name.name,
      username: "test_#{index}",
      email: "test_#{index}@test.com",
      password: 'password',
      password_confirmation: 'password',
      confirmed_at: Time.now.utc,
      profile_picture: profile_picture,
      preffered_distance: 0
    )
  end

  private

  def profile_picture
    url = ::Faker::LoremFlickr.image(size: '170x170', search_terms: ['people'])
    file = URI.parse(url).open
    ActiveStorage::Blob.create_and_upload!(
      io: file,
      filename: File.basename(file.base_uri.path),
      content_type: file.content_type
    )
  end
end