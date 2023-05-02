# frozen_string_literal: true

require 'rails_helper'

describe NearbyUsersController, type: :controller do
  let(:user) { create(:user) }
  let(:nearby_user) { create(:user) }

  before do
    byebug
    sign_in user
  end

  describe 'GET #index' do
    before do
      get :index, params: { lat: geolocation.lat, lng: geolocation.lng }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns nearby users' do
      expect(json['data'].length).to eq(1)
    end
  end
end