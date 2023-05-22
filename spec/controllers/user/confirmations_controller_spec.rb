# frozen_string_literal: true

require 'rails_helper'

describe User::ConfirmationsController do
  include ControllerHelpers

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'unauthenticated' do
    describe 'new' do
      it 'returns unauthorized' do
        get :new

        expect(response).to have_http_status(:no_content)
      end
    end
  end

  context 'authenticated' do
    let(:user) { User.first }

    describe 'new' do
      it 'returns new confirmation instructions' do
        sign_in(user)

        allow_any_instance_of(User).to receive(:confirmed?).and_return(false)

        get :new

        expect(response).to have_http_status(:success)
      end

      it 'aborts if user already confirmed' do
        sign_in(user)

        get :new

        expect(response).to have_http_status(:success)

        end
    end
  end
end