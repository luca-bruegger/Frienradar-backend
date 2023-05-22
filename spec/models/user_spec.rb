# frozen_string_literal: true

require 'rails_helper'

describe User do

  context 'create' do
    it 'aborts if validations fails' do
      user = User.new
      expect(user.save).to be_falsey
    end

    it 'aborts if validations fails' do
      user = User.new(
        email: Faker::Internet.email,
        password: Faker::Internet.password,
        name: Faker::Name.name,
        profile_picture: fixture_file_upload("spec/fixtures/files/avatar.jpeg", 'jpeg')
      )
      expect(user.save).to be_truthy
    end
  end

end