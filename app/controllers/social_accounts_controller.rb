# frozen_string_literal: true

class SocialAccountsController < CrudController
  before_action :authenticate_user!

  private

  def build_entry
    instance_variable_set(:"@#{model_identifier}", current_user.add_social_account(provider, username))
  end

  def permitted_attrs
    [:provider, :username]
  end

  def provider
    model_params[:provider]
  end

  def username
    model_params[:username]
  end

  def fetch_entries
    current_user.social_accounts
  end
end
