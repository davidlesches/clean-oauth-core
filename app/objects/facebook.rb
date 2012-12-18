class Facebook

  def initialize facebook_account
    @account = facebook_account
  end

  def refresh_friends
    fb_friends = koala.get_connections "me", "friends"
    fb_friends.each do |friend|
      fb_friend = Account.find_by_provider_and_uid('facebook', friend["id"]) and fb_friend = fb_friend.user
      @account.user.followings << fb_friend if fb_friend.present? && !@account.user.followings.include?(fb_friend)
      @account.user.followers << fb_friend if fb_friend.present? && !@account.user.followers.include?(fb_friend)
    end
  end

  def refresh_checkins
    koala.get_connections("me", "statuses").each do |status|
      policy  = FacebookCheckinPolicy.new(status)
      checkin = CheckinCreator.new(policy)
      record  = checkin.save
      record.update_attributes(user_id: @account.user.id) if record
    end
  end



  private

    def koala
      @facebook ||= Koala::Facebook::API.new(@account.oauth_token)
      block_given? ? yield(@facebook) : @facebook
    rescue Koala::Facebook::APIError => e
      logger.info "Facebook API Error: #{e.to_s}"
      nil
    end

end