APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, APP_CONFIG['fb_app_id'], APP_CONFIG['fb_secret'], {
    :client_options => {
      :ssl => APP_CONFIG["ssl_certs"]
    },
    :scope => APP_CONFIG["fb_permissions"]
  }

  provider :foursquare, APP_CONFIG['foursquare_id'], APP_CONFIG['foursquare_secret'], {
    :client_options => {
      :ssl => APP_CONFIG["ssl_certs"]
    }
  }

  provider :twitter, APP_CONFIG['twitter_id'], APP_CONFIG['twitter_secret'], {
    :client_options => {
      :ssl => APP_CONFIG["ssl_certs"]
    }
  }
end

Koala.http_service.http_options = {
  :ssl => { :verify => false }
}