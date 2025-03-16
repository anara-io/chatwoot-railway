# config/initializers/cors.rb
# ref: https://github.com/cyu/rack-cors

# font cors issue with CDN
# Ref: https://stackoverflow.com/questions/56960709/rails-font-cors-policy
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Parse allowed origins from environment variable or default to '*'
    allowed_origins = ENV.fetch('CW_CORS_ALLOWED_ORIGINS', '*')
    # If the value is not '*', split by comma and strip whitespace
    origins_list = allowed_origins == '*' ? ['*'] : allowed_origins.split(',').map(&:strip)

    origins origins_list
    resource '/packs/*', headers: :any, methods: [:get, :options]
    resource '/audio/*', headers: :any, methods: [:get, :options]
    # Make the public endpoints accessible to the frontend
    resource '/public/api/*', headers: :any, methods: :any

    # Enable API access by default, can be disabled with CW_ENABLE_API_ACCESS=false
    if ActiveModel::Type::Boolean.new.cast(ENV.fetch('CW_ENABLE_API_ACCESS', true)) ||
       ActiveModel::Type::Boolean.new.cast(ENV.fetch('CW_API_ONLY_SERVER', false)) ||
       Rails.env.development?
      # Allow access to all API endpoints and expose authentication headers
      resource '*', headers: :any, methods: :any, expose: %w[access-token client uid expiry]
    end
  end
end

################################################
######### Action Cable Related Config ##########
################################################

# Mount Action Cable outside main process or domain
# Rails.application.config.action_cable.mount_path = nil
# Rails.application.config.action_cable.url = 'wss://example.com/cable'
# Rails.application.config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

# To Enable connecting to the API channel public APIs
# ref : https://medium.com/@emikaijuin/connecting-to-action-cable-without-rails-d39a8aaa52d5
Rails.application.config.action_cable.disable_request_forgery_protection = true
