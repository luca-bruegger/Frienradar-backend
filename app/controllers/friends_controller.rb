# frozen_string_literal: true

require 'will_paginate/array'

class FriendsController < CrudController

  def show
    authorize model_class, policy_class: FriendPolicy
    render_entry
  end

  private

  def render_entry
    render json: {
      data: model_serializer.new(entry).serializable_hash[:data]
    }, status: :ok
  end

  def model_class
    :friend
  end

  def model_serializer
    Friend::MinimalSerializer
  end

  def entry
    current_user.friends.paginate(page: page)
  end
end
