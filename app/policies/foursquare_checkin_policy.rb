class FoursquareCheckinPolicy

  def initialize checkin
    @checkin = checkin
  end

  def id
    @checkin["id"]
  end

  def provider
    'foursquare'
  end

  def created_at
    Time.at(@checkin["createdAt"].to_i)
  end

  def comment
    @checkin["shout"]
  end

  def categories
    unless @checkin["venue"]["categories"].nil?
      @checkin["venue"]["categories"].map { |i| i["pluralName"] unless i["pluralName"].nil?  }.join(', ')
    end
  end

  def venue
    @checkin["venue"]
  end

  def location
    @checkin["venue"]["location"]
  end

  def venue_name
    @checkin["venue"]["name"]
  end

  def address
    @checkin["venue"]["location"]["address"]
  end

  def city
    @checkin["venue"]["location"]["city"]
  end

  def state
    @checkin["venue"]["location"]["state"]
  end

  def zip
    @checkin["venue"]["location"]["postalCode"]
  end

  def longitude
    @checkin["venue"]["location"]["lng"]
  end

  def latitude
    @checkin["venue"]["location"]["lat"]
  end

end