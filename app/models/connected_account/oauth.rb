module ConnectedAccount::Oauth
  extend ActiveSupport::Concern

  included do
    encrypts :access_token
    encrypts :access_token_secret

    # Scopes for each provider
    Devise.omniauth_configs.each do |provider, _|
      scope provider, -> { where(provider: provider) }
    end

    scope :for_auth, ->(auth, **query) { where(query.with_defaults(provider: auth.provider, uid: auth.uid)) }
  end

  def provider_name
    Jumpstart::Omniauth::AVAILABLE_PROVIDERS.dig(provider, :name) || provider.humanize
  end

  def name
    auth&.dig("info", "name")
  end

  def email
    auth&.dig("info", "email")
  end

  def image_url
    auth&.dig("info", "image") || GravatarHelper.gravatar_url_for(email)
  end
end
