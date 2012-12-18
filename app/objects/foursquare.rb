class Foursquare

  include HTTParty
  BASE_URI = "https://api.foursquare.com/v2/"

  def initialize foursquare_account
    @account = foursquare_account
  end

  def refresh_checkins
    get_checkins.each do |status|
      policy  = FoursquareCheckinPolicy.new(status)
      checkin = CheckinCreator.new(policy)
      record  = checkin.save
      record.update_attributes(user_id: @account.user.id) if record
    end
  end


  private

    def get_checkins
      Foursquare.get(BASE_URI + "users/#{@account.uid}/checkins?oauth_token=#{@account.oauth_token}&v=#{Time.now.to_date.strftime("%Y%m%d")}&limit=250")["response"]["checkins"]["items"]
    end

end