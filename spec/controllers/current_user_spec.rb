# frozen_string_literal: true

require 'rails_helper'

describe CurrentUserController do
  include ControllerHelpers

  context 'unauthenticated' do
    describe 'index' do
      it 'returns current user' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end

    end
  end

  context 'authenticated' do
    user = User.first

    before(:each) do
      sign_in(user)
    end

    describe 'index' do
      it 'returns current user' do
        allow_any_instance_of(User).to receive(:profile_picture).and_return(OpenStruct.new(url: 'http://example.com'))

        get :index

        expect(response).to have_http_status(:success)

        body = JSON.parse(response.body, object_class: OpenStruct)

        expect(body.status.code).to eq(200)

        expect(body.data.guid).to eq(user.guid)
        expect(body.data.email).to eq(user.email)
        expect(body.data.name).to eq(user.name)
        expect(body.data.confirmed).to eq(user.confirmed?)
        expect(body.data.profile_picture).to eq(user.profile_picture.url)
      end
    end
  end
end