class FacebookCheckinPolicy

  def initialize checkin
    @checkin = checkin
  end

  def id
    @checkin["id"]
  end

  def provider
    'facebook'
  end

  def created_at
    @checkin["updated_time"].to_datetime
  end

  def comment
    @checkin["message"]
  end

  def categories
    nil
  end

  def venue
    @checkin["place"]
  end

  def location
    @checkin["place"]["location"]
  end

  def venue_name
    @checkin["place"]["name"]
  end

  def address
    @checkin["place"]["location"]["street"]
  end

  def city
    @checkin["place"]["location"]["city"]
  end

  def state
    @checkin["place"]["location"]["state"]
  end

  def zip
    @checkin["place"]["location"]["zip"]
  end

  def longitude
    @checkin["place"]["location"]["longitude"]
  end

  def latitude
    @checkin["place"]["location"]["latitude"]
  end

end