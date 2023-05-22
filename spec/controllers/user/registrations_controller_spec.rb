# frozen_string_literal: true

require 'rails_helper'

describe User::RegistrationsController do
  include ControllerHelpers

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'create' do
    it 'aborts if validations fails' do

      post :create, params: {
        email: '',
        password: '',
        name: '',
        profile_picture: fixture_file_upload("spec/fixtures/files/avatar.jpeg", 'jpeg')
      }

      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body, object_class: OpenStruct)

      expect(body.message).to include("User couldn't be created successfully.")
    end

    it 'creates user' do
      allow_any_instance_of(User).to receive(:profile_picture).and_return(OpenStruct.new(url: 'http://example.com'))

      user = {
        unconfirmed_email: Faker::Internet.email,
        password: Faker::Internet.password,
        name: Faker::Name.name,
        profile_picture: fixture_file_upload("spec/fixtures/files/avatar.jpeg", 'jpeg')
      }

      post :create, params: user

      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body, object_class: OpenStruct)

      expect(body.message).to eq("Signed up sucessfully.")
    end
  end
end