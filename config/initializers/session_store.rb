# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

options = {
  key: '_twist_session'
}

case Rails.env
when 'development', 'test'
  options.merge!(domain: 'localhost')
when 'production'
  # TBA
end

Rails.application.config.session_store :cookie_store, **options
