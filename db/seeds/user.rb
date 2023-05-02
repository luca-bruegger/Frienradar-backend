# frozen_string_literal: true

class UserSeeds
  def self.generate
    30.times do |index|
      index % 10 == 0 ? puts('Seeding users @' + index.to_s) : nil
      new.generate(index)
    end
  end

  def generate(index)
    begin
      User.create!(
        name: ::Faker::Name.name,
        username: ::Faker::Internet.username(specifier: 3..30),
        email: "test#{index}@test.com",
        password: 'password',
        password_confirmation: 'password',
        confirmed_at: Time.now.utc,
        profile_picture: profile_picture,
        preferred_distance: 0
      )
    rescue ActiveRecord::RecordInvalid => e
      puts e
    end
  end

  private

  def profile_picture
    url = ::Faker::LoremFlickr.image(size: '300x300', search_terms: ['people'])
    file = URI.parse(url).open
    ActiveStorage::Blob.create_and_upload!(
      io: file,
      filename: File.basename(file.base_uri.path),
      content_type: file.content_type
    )
  end
end