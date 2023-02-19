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
    before(:each) do
      sign_in(User.first)
    end

    describe 'index' do
      it 'returns current user' do
        get :index
        expect(response).to have_http_status(:success)
        data = JSON.parse(response.body)
        byebug
      end
    end
  end
end