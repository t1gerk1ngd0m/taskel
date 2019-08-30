require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Taskel
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :utc 
    config.generators.template_engine = :slim #slimに変更

    config.generators do |g|
      g.test_framework false

      config.i18n.default_locale = :ja # デフォルトのlocaleを日本語(:ja)にする
      config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    end

    config.assets.precompile += %w[admin/active_admin.css admin/active_admin.js]

    config.autoload_paths += Dir["#{config.root}/lib/tasks"]

    # config.autoload_paths += Dir[Rails.root.join('app', 'uploaders')]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
