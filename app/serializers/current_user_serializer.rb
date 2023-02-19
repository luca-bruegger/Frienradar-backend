# frozen_string_literal: true

class CurrentUserSerializer
  include JSONAPI::Serializer
  attributes :guid, :email
end
