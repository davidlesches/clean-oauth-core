class CheckinCreator

  # Object to deal with the creation of Checkin objects, via a Policy object.

  attr_reader :persistance

  def initialize policy
    @policy = policy
  end

  def save
    # No point saving for this app if we can't plot it on a map
    # or if it is already saved.
    return false if not_plottable? || persisted?

    # Create location if necessary
    create_location if location.nil?

    # Terminate if location could not be created
    return false if location.nil?

    Checkin.create!(
      :provider     => @policy.provider,
      :cid          => @policy.id,
      :location_id  => location.id,
      :checkin_time => @policy.created_at,
      :comment      => @policy.comment,
      :store_id     => store.id
    )
  end

  def persisted?
    Checkin.exists?(
      :cid      => @policy.id,
      :provider => @policy.provider
    )
  end

  def persistance
    Checkin.find_by_provider_and_cid(@policy.provider, @policy.id)
  end

  def plottable?
    !not_plottable?
  end

  def not_plottable?
    @policy.venue.nil? || @policy.location.nil?
  end


  private

    def google
      # We use the GoogleMaps ID number to help normalize Facebook locations with Foursquare Locations
      # on the map.
      @data ||= GoogleMaps.locate_store_by_longlat(
        :store_name => @policy.venue_name,
        :longitude  => @policy.longitude,
        :latitude   => @policy.latitude
      )
    end

    def store
      @store ||= Store.find_or_create_by_name @policy.venue_name
    end

    def location
      return nil if google.nil?
      Location.find_by_google_id google['id']
    end

    def create_location
      return false if google.nil?
      store.locations.create!(
        :store_id         => store.id,
        :address          => @policy.address,
        :city             => @policy.city,
        :state            => @policy.state,
        :zip              => @policy.zip,
        :longitude        => @policy.longitude,
        :latitude         => @policy.latitude,
        :google_reference => google['reference'],
        :google_id        => google['id']
      )
    end

end