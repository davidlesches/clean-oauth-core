class TwitterPolicy

  def initialize auth
    @auth = auth
  end

  def first_name
    split_name.first
  end

  def last_name
    split_name.last
  end

  def email
    nil
  end

  def username
    @auth.info.nickname
  end

  def image_url
    "https://api.twitter.com/1/users/profile_image?screen_name=#{@auth.info.nickname}&size=original"
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
    @auth.credentials.secret
  end

  def create_callback account
    # Place any methods you want to trigger on Twitter OAuth creation here.
  end

  def refresh_callback account
    # Place any methods you want to trigger on Twitter OAuth creation here.
  end



  private

    def split_name
      name = @auth.info.name
      if name.include?(" ")
        last_name  = name.split(" ").last
        first_name = name.split(" ")[0...-1].join(" ")
      else
        first_name = name
        last_name  = nil
      end
      [first_name, last_name]
    end

end