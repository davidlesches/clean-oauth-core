class FoursquarePolicy

  def initialize auth
    @auth = auth
  end

  def first_name
    @auth.info.first_name
  end

  def last_name
    @auth.info.last_name
  end

  def email
    @auth.info.email
  end

  def username
    @auth.info.nickname
  end

  def image_url
    @auth.info.image
  end

  def uid
    @auth.uid
  end

  def oauth_token
    @auth.credentials.token
  end

  def oauth_expires
    nil
  end

  def oauth_secret
    nil
  end

  def create_callback account
    # Place any methods you want to trigger on Foursquare OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on Foursquare OAuth creation here.
  end

end